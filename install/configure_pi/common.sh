#!/bin/bash

PASS=$1
TYPE=$2
HOSTNAME=${3:-cedille}
SSID=${4:-RocketCam} 

#The following line will configure the raspiberry pi 
raspi-config nonint do_hostname $HOSTNAME
raspi-config nonint do_camera 0 #Enable the camera
(echo $PASS ; echo $PASS ; echo $PASS) | passwd pi

echo "Updating the database"
echo "..."
apt-get update -yq
echo "Done"

echo "Installing crons"
mv /home/pi/install/cron_register_watcher /etc/cron.d/cron_register_watcher
mv /home/pi/install/cron_restart_watcher /etc/cron.d/cron_restart_watcher
chown root:root /etc/cron.d/cron_register_watcher
chown root:root /etc/cron.d/cron_restart_watcher