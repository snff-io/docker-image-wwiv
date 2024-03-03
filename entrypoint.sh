#!/bin/sh

PATH=/opt/wwiv:$PATH
export PATH

set -xe

if [ ! -d data ]; then
	cp -a /opt/wwiv/* .
	#cp -a /opt/wwiv/admin/* .
	#cp inifiles/* .
fi


# while [ ! -f data/wwivd.json ]; do
# 	cat <<-EOF
# 	**********************************************************************
# 	You must configure the wwivd settings (select 'w' from the main
# 	menu).
# 	**********************************************************************

# 	EOF

# 	echo "Press RETURN to run wwivconfig"
# 	read key
# 	/opt/wwiv/wwivconfig
	
# done

chown -R wwiv:wwiv .

# Check if running in interactive mode
if [ -t 0 ]; then
    set +xe
    echo "WWIV_MODE = $WWIV_MODE"
    if [ "$WWIV_MODE" == "wfc" ]; then
        /srv/wwiv/bbs
    elif [ "$WWIV_MODE" == "config" ]; then
        /srv/wwiv/wwivconfig
    else
        if [ ! -f data/wwivd.json ]; then
            echo "**********************************************************************"
            echo "THERE IS NO WWIVD.JSON!"
            echo "You MUST choose option 'c' to configure your new BBS!"
            echo "At a minimum you MUST enter the wwivd config section 'w'"
            echo "to write a config.                                     (entrypoint.sh)"
            echo "**********************************************************************"
       fi

        echo "**********************************************************************"
        echo "Running in interactive mode!"
        echo "Choose to run the BBS or WWIVConfig."
        echo "b) BBS (default) -> WWIVD"
        echo "c) WWIVConfig -> WWIVD"
        echo "d) WWIVD                                               (entrypoint.sh)"
        echo "**********************************************************************"

        echo -n "d, c or b (default): "
        read key
        if [ "$key" == "c" ]; then
            /srv/wwiv/wwivconfig
        elif [ "$key" == "d" ]; then
            echo "wwivd"
        else
            /srv/wwiv/bbs
        fi
    fi
else
    echo "Running in non-interactive mode"
fi

HOME=/srv/wwiv exec /sbin/runuser -p -u wwiv -- "$@"
