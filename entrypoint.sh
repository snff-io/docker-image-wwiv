#!/bin/sh

PATH=/opt/wwiv:$PATH
export PATH

-xe

if [ ! -d data ]; then
	cp -a /opt/wwiv/* .
	#cp -a /opt/wwiv/admin/* .
	#cp inifiles/* .
fi


while [ ! -f data/wwivd.json ]; do
	cat <<-EOF
	**********************************************************************
	You must configure the wwivd settings (select 'w' from the main
	menu).
	**********************************************************************

	EOF

	echo "Press RETURN to run wwivconfig"
	read key
	/opt/wwiv/wwivconfig
	
done

chown -R wwiv:wwiv .

# Check if running in interactive mode
if [ -t 0 ]; then
    echo "Running in interactive mode"
    echo "b) bbs"
    echo "c) wwivconfig"
    echo -n "B/c: "
    read key
    if [ "$key" == "c" ]; then
        /srv/wwiv/wwivconfig
    else
        /srv/wwiv/bbs
    fi
else
    echo "Running in non-interactive mode"
fi


HOME=/srv/wwiv exec /sbin/runuser -p -u wwiv -- "$@"
