#!/bin/bash

ip n | cut -d ' ' -f 1 > /tmp/ips.txt

while read in; do
  ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no pi@$in 'touch /var/www/html/start_video';
done < /tmp/ips.txt

rm /tmp/ips.txt
