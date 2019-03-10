#!/bin/sh

# This file is used to automatically update state od devices in domoticz

# import domoticz common functions with config

. /system/sdcard/scripts/domoticz_common_functions.sh
. /system/sdcard/scripts/common_functions.sh

PIDFILE='/run/domoticz.pid'

if [ ! -f /system/sdcard/config/domoticz.conf ]; then
  echo "You have to configure domoticz first. Please see /system/sdcard/config/domoticz.conf.dist for further instructions"
fi

if [ $CONNECT_TO_DOMOTICZ==1 ]; then
	while true; do
		if [ $IDX_RTSP -ne 0 ]; then
			PID=$(/system/sdcard/controlscripts/rtsp-h264 status)
			if [ "$PID" != "" ]; then
				domoticz_send_state $IDX_RTSP 1
			else
				domoticz_send_state $IDX_RTSP 0
			fi
			sleep 60;
		fi;
		
		if [ $IDX_TIMELAPS -ne 0 ]; then
			PID=$(/system/sdcard/controlscripts/timelapse status)
			if [ "$PID" != "" ]; then
				domoticz_send_state $IDX_TIMELAPS 1
			else
				domoticz_send_state $IDX_TIMELAPS 0
			fi
			sleep 60;
		fi;
		
		if [ $IDX_NIGHT_MODE -ne 0 ]; then
			PID=$(night_mode status)
			if [ "$PID" != "OFF" ]; then
				domoticz_send_state $IDX_NIGHT_MODE 1
			else
				domoticz_send_state $IDX_NIGHT_MODE 0
			fi
		
			sleep 60;
		fi;
			
		sleep $DOMOTICZ_TIMELAPSE_INTERVAL
	done
fi;
	
# loop completed so let's purge pid file
rm "$PIDFILE"
