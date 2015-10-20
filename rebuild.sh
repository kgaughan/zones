#!/bin/sh

ODS_ROOT=/usr/local/var/opendnssec
NSD_ZONES=/usr/local/etc/nsd/zones

get_zones () {
	# Unsigned zones have the lowest priority, so we link them first.
	find $ODS_ROOT/unsigned -depth 1 -type f \
		-and ! \( -name README.md -or -name .gitignore -or -name rebuild.sh \)
	# Then we link signed zones, which will overwrite the links for any
	# unsigned zones.
	find $ODS_ROOT/signed -depth 1 -type f
}

write_zone () {
	cat <<EOZ
zone:
	name: "$1"
	include-pattern: "master"
EOZ
}

get_zones | while read zone; do
	ln -s -f $zone $NSD_ZONES/$(basename $zone).zone
done

for zonefile in $NSD_ZONES/*; do
	if test -L $zonefile; then
		write_zone $(basename $zonefile .zone)
	fi
done > $NSD_ZONES/../zones.conf
