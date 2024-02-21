#!/bin/sh

PATH=/opt/wwiv:$PATH
export PATH

if [ ! -d data ]; then
	cp -a /opt/wwiv/admin/* .
	cp inifiles/* .
fi

echo "SITUATION_INTERACTIVE="$INTERACTIVE	

cd /opt/wwiv

while [ ! -f data/wwivd.json ]; do
	cat <<-EOF
	**********************************************************************
	You must configure the wwivd settings (select 'w' from the main
	menu).
	**********************************************************************

	EOF

	echo "Press RETURN to run wwivconfig"
	read key

	wwivconfig
done

chown -R wwiv:wwiv .

HOME=/srv/wwiv exec /sbin/runuser -p -u wwiv -- "$@"
