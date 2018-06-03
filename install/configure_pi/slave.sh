#!/bin/bash

PASS=$1
TYPE=$2
HOSTNAME=${3:-cedille}
SSID=${4:-RocketCam} 

bash ./install/configure_pi/common.sh $PASS $TYPE $HOSTNAME $SSID

echo "Installing inotify-tools"
apt-get install inotify-tools -yqq
echo "Done"

echo "Installing Default network"
cat >> /etc/network/interfaces  << END
auto lo
 
iface lo inet loopback
iface eth0 inet dhcp
 
allow-hotplug wlan0
auto wlan0
 
 
iface wlan0 inet dhcp
        wpa-ssid "$SSID"
        wpa-psk "$PASS"
END

echo "Installing the app"
mkdir -p /var/www/html
mv app /var/www/html
chmod -R 777 /var/www/html

echo "Installation completed! Please reboot."
