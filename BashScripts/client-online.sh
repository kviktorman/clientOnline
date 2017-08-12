#!/bin/bash

#set interface
interface=$1;

#get interface MAC and IP address
addressIP=`ifconfig $interface | grep "inet addr" | cut -d ':' -f 2 | cut -d ' ' -f 1`;
addressMAC=`cat /sys/class/net/$interface/address`;

#read configuration settings
CONFIGURATION=`cat ./configuration/server.json`;

# bind settings to variable and remove quotation marks if required
SERVERURL=`echo $CONFIGURATION | jq ".maintainerURL"`;
SERVERURL=${SERVERURL:1:-1};
LOGFILE=`echo $CONFIGURATION | jq ".clientLogFile"`;
LOGFILE=${LOGFILE:1:-1};

messageRequest="{\"messageName\":\"Identification\",";
messageRequest="$messageRequest \"addressMAC\":\"$addressMAC\",";
messageRequest="$messageRequest \"addressIP\":\"$addressIP\",";
messageRequest="$messageRequest \"idHW\":\"xxxx-xxxx-xxxx\"";
messageRequest="$messageRequest}";

echo "[$(date +'%Y.%m.%d %T') - client-online] MAC: $addressMAC" >> $LOGFILE;
echo "[$(date +'%Y.%m.%d %T') - client-online] IP: $addressIP" >> $LOGFILE;

#send for server folder list and version.json if exist
identification=$(curl -H "Accept: application/json" -H "Content-Type: application/json" -X POST -d "$messageRequest" $SERVERURL);

status=`echo $identification | jq ".status"`;

if [ $status -eq 0 ]; then
    echo "[$(date +'%Y.%m.%d %T') - client-online] identification sent" >> $LOGFILE;
else
    errorMSG=`echo $identification | jq ".msg"`;
    echo "[$(date +'%Y.%m.%d %T') - client-online] Error code: $status" >> $LOGFILE;
    echo "[$(date +'%Y.%m.%d %T') - client-online] Error message: $errorMSG" >> $LOGFILE;
fi

exit 0;