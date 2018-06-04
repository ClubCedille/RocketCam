#!/bin/bash

PASS=$1
TYPE=$2
HOSTNAME=${3:-cedille}
SSID=${4:-RocketCam} 

bash ./install/configure_pi/common.sh $PASS $TYPE $HOSTNAME $SSID

echo "Installing php, apache and inotify-tools"
apt-get install php inotify-tools -yqq
a2enmod rewrite
echo "Done"

echo "Configuring apache"
rm /etc/apache2/sites-available/000-default.conf
touch /etc/apache2/sites-available/000-default.conf

cat >> /etc/apache2/sites-available/000-default.conf  << END
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

echo "Installing ssh key"
mkdir -p .ssh

mv ./install/rsa/.ssh/id_rsa .ssh/
mv ./install/rsa/.ssh/id_rsa.pub .ssh/

chmod 700 .ssh
chmod 600 .ssh/id_rsa
chmod 644 .ssh/id_rsa.pub
chown -R pi:pi .ssh

echo "Installing the app"
rm -r /var/www/html
mv app /var/www/html
chmod -R 777 /var/www/html
chown -R www-data:www-data /var/www/html

echo "Configuring Access Point"
bash ./install/access-point.sh $PASS $SSID

echo "Installation completed! Please reboot."

