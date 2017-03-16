#!/bin/sh

if [ ! -d data ]; then
	cp -a /opt/wwiv/admin/* .
	cp inifiles/* .
fi

while [ ! -f data/wwivd.json ]; do
	cat <<-EOF
	**********************************************************************
	You must configure the wwivd settings (select 'w' from the main
	menu).
	**********************************************************************

	EOF

	echo "Press RETURN to run init"
	read key

	/opt/wwiv/init
done

chown -R wwiv:wwiv .

HOME=/srv/wwiv exec /sbin/runuser -p -u wwiv -- "$@"
