#!/bin/bash

echo "dtoverlay=dwc2" >> config.txt
sed -i 's/rootwait/rootwait modules-load=dwc2,g_ether/' cmdline.txt
touch ssh