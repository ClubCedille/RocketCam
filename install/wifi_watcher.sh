#!/bin/bash
#Thanks to http://alexba.in/blog/2015/01/14/automatically-reconnecting-wifi-on-a-raspberrypi/

#ping master
ping -c2 -W2 10.0.0.1 > /dev/null

#Check for ping error
if [ $? != 0 ]
then
    ifdown --force wlan0
    ifup wlan0
fi