#!/bin/sh

CurrentPic=$(ls /system/sdcard/DCIM/timelapse/ | tail -1)
cp /system/sdcard/DCIM/timelapse/$CurrentPic /system/sdcard/www/current_pic.jpg
echo "OK"
