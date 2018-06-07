#!/bin/bash

#This will clean the existing file that could persist after a reboot and we probably don't want them
rm -f /var/www/html/start_video
rm -f /var/www/html/stop_video
rm -f /var/www/html/snapshot
rm -f /var/www/html/session.json

