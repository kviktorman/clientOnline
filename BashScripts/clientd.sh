#!/bin/sh

serviceTask=$1;
DAEMON_LOCATION="/opt/client-online";

cd "$DAEMON_LOCATION";

case $serviceTask in
    start)

        # send availability based on on interface name
        eval "./client-online.sh wlan0";
        eval "./client-online.sh eth0";        
        ;;
    stop)
        ;;
esac

exit 0;