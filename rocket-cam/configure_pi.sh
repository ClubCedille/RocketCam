#!/bin/bash

if [ -z $1 ] 
then 
  echo "Default hostname is cedille";
  echo "Usage: sudo configure_pi.sh [password] [slave or master] [hostname] [SSID]";
  exit;
fi

PASS=$1
TYPE=$2
HOSTNAME=${3:-cedille}
SSID=${4:-RocketCam} 

if [ $TYPE = "master" ] 
then
  bash ./rocket-cam/configure_pi/master.sh $PASS $TYPE $HOSTNAME $SSID
else
  bash ./rocket-cam/configure_pi/slave.sh $PASS $TYPE $HOSTNAME $SSID
fi
