#!/bin/bash

if [ -z $1 ] 
then 
  echo "Default hostname is cedille";
  echo "Usage: sudo configure_pi.sh [password] [hostname]";
  exit;
fi

PASS=$1
HOSTNAME=${2:-cedille} 

#The following line will configure the raspiberry pi 
raspi-config nonint do_hostname $HOSTNAME
raspi-config nonint do_camera 0 #Enable the camera
(echo $PASS ; echo $PASS ; echo $PASS) | passwd pi

apt-get update -y
apt-get install php -y
bash ./access-point.sh rocket-cam $PASS

