#!/bin/bash
DATE=$(date +%s%3N);
/opt/vc/bin/raspivid -t 0 -w 1280 -h 720 -hf -ih -fps 30 -b 8000000 -o "/var/www/html/recording/video-$DATE.h264"

