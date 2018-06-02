#!/bin/bash

INSTALL_FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "dtoverlay=dwc2" >> config.txt
sed -i 's/rootwait/rootwait modules-load=dwc2,g_ether/' cmdline.txt
touch ssh

cd "../rootfs/home/pi"
cp -r "$INSTALL_FOLDER/../app" ./
cp -r "$INSTALL_FOLDER" ./
