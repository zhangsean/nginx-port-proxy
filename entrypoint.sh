#!/bin/sh

set -e

CONFIG_FILE=/etc/nginx/nginx.conf

if ( cat $CONFIG_FILE | grep -q '${PROTO}' ); then

    if ( echo "$1" | grep -q ":" ); then
        ARG=$1
        if ( echo $ARG | grep -q "/" ); then
            PROTO=`echo $ARG | awk -F/ '{print $2}'`
            ARG=`echo $ARG | awk -F/ '{print $1}'`
        fi
        REMOTE_SERVER=`echo $ARG | awk -F: '{print $1}'`
        REMOTE_PORT=`echo $ARG | awk -F: '{print $2}'`
    fi

    if [ "$PROTO" == "tcp" ]; then
        PROTO=""
    fi

    eval "cat << EOF
`cat $CONFIG_FILE`
EOF" > $CONFIG_FILE

fi

nginx -t
nginx -g "daemon off;"
