#!/bin/sh
for zonefile in $(find $(dirname $0) -depth 1 -type f -and ! \( -name README.md -or -name .gitignore -or -name rebuild.sh \) -exec basename {} \;); do
	cat <<EOZ
zone:
	name: "$zonefile"
	include-pattern: "master"
EOZ
done > /usr/local/etc/nsd/zones.conf
