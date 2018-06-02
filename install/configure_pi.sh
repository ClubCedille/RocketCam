#!/bin/bash

if [ -z $1 ] 
then 
  echo "Default hostname is cedille";
  echo "Usage: sudo configure_pi.sh [password] [hostname] [SSID]";
  exit;
fi

PASS=$1
HOSTNAME=${2:-cedille} 
SSID=${3:-RocketCam} 

#The following line will configure the raspiberry pi 
raspi-config nonint do_hostname $HOSTNAME
raspi-config nonint do_camera 0 #Enable the camera
(echo $PASS ; echo $PASS ; echo $PASS) | passwd pi

#apt-get update -y
apt-get install php inotify-tools -y

a2enmod rewrite

rm /etc/apache2/sites-available/000-default.conf
touch /etc/apache2/sites-available/000-default.conf

tee -a /etc/apache2/sites-available/000-default.conf  << END
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html/public

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        <Directory /var/www/html/public>
                Options Indexes FollowSymLinks
                AllowOverride All
                Require all granted
        </Directory>

</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
END

rm -r /var/www/html
mv app /var/www/html
chmod -R 777 /var/www/html
chown -R www-data:www-data /var/www/html

mv /home/pi/install/cron_register_watcher /etc/cron.d/watcher

bash ./install/access-point.sh $SSID $PASS

