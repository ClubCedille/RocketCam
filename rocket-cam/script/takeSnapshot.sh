#!/bin/bash
/opt/vc/bin/raspistill -q 30 -w 480 -h 320 --nopreview --timeout 1 -o "/var/www/html/picture/picture.jpg"