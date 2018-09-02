#!/bin/sh

# This file is used to connect device to domoticz, consist of general functions to send states to domoticz

# include domoticz configuration
. /system/sdcard/config/domoticz.conf

domoticz_send_state(){
if [ $CONNECT_TO_DOMOTICZ==1 ]; then
  IDX=$1
  STATE=$2
	if [ -n "$1" ] && [ -n "$2" ] && [ $1 -ne 0 ]; then
		URL="http://$DOMOTICZ_IP:$DOMOTICZ_PORT/json.htm?type=command&param=udevice&idx=$IDX&nvalue=$STATE";
		/system/sdcard/bin/curl $URL -o /dev/null 2>/dev/null
	fi;
fi;
}
