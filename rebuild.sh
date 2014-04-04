#!/bin/sh
for zonefile in $(dirname $0)/*.zone; do cat <<EOZ
zone:
	name: "$(basename $zonefile .zone)"
	include-pattern: "master"
EOZ
done > $(dirname $0)/zones.conf
