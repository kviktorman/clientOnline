#!/bin/sh

serviceTask=$1;
DAEMON_LOCATION="/opt/client-online";

cd "$DAEMON_LOCATION";

case $serviceTask in
    start)

        # giving 10 s delay for IP request after network is up
        eval "sleep 10";

        # send availability based on on interface name
        eval "./client-online.sh wlan0";
        eval "./client-online.sh eth0";        
        ;;
    stop)
        ;;
esac

exit 0;