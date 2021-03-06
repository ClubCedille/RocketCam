#!/bin/bash
#What this line does is check in the process list if this file is already running
#If it's running it should be counted as 2
LENGTH=`ps -ax | grep camera_watcher.sh | grep -v "grep" | wc -l`

if [[ $LENGTH -gt 2 ]]
then 
  exit;
fi

#This will register inotify to watch for file creation in 
#the application directory. if the file is being created it remove it and 
#launch the video or take a picture
inotifywait -e close_write -m  /var/www/html/ |
while read -r directory events filename; do
  if [ "$filename" = "start_video" ]; then
    rm /var/www/html/start_video
    /bin/bash /home/pi/rocket-cam/script/startVideos.sh
    /bin/bash /home/pi/rocket-cam/script/startVideo.sh & disown
  fi
  if [ "$filename" = "stop_video" ]; then
    rm /var/www/html/stop_video
    /bin/bash /home/pi/rocket-cam/script/stopVideos.sh
    /bin/bash /home/pi/rocket-cam/script/stopVideo.sh
  fi
  if [ "$filename" = "snapshot" ]; then
    rm /var/www/html/snapshot
    /bin/bash /home/pi/rocket-cam/script/takeSnapshot.sh
  fi
done