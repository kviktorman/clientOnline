#!/bin/sh

serviceTask=$1;
DAEMON_LOCATION="/opt/client-online";

cd "$DAEMON_LOCATION";

pwd;

case $serviceTask in
    start)
        
        # send availability based on on interfaces
        eval "./client-online.sh wlan0";
        eval "./client-online.sh eth0";        
        ;;
    stop)
        ;;
esac

exit 0;