#!/bin/sh

if [ ! -d data ]; then
	cp -a /opt/wwiv/admin/* .
	cp inifiles/* .
	/opt/wwiv/init
fi

chown -R wwiv:wwiv .

HOME=/srv/wwiv exec /sbin/runuser -p -u wwiv "$@"
