#!/bin/bash
# Automated LEMP installer for Ubuntu 16.04+
echo This script will install the LEMP Stack
sudo apt-get install nginx -y
# wget config then cp the file
wget https://raw.githubusercontent.com/upodroid/Configurations/master/nginx
mv nginx default
cp default /etc/nginx/sites-available
sudo nginx -t
sudo apt-get install php7.0-fpm php7.0-mysql php7.0-mcrypt php-mbstring php-gettext -y
sudo phpenmod mcrypt
sudo phpenmod mbstring
sudo systemctl start php7.0-fpm
sudo systemctl restart nginx.service
sudo apt install php7.0-mcrypt php7.0-mbstring -y
sudo systemctl restart php7.0-fpm.service
sudo apt install mariadb-server mariadb-client php7.0-mysql -y
sudo systemctl restart php7.0-fpm.service
sudo mysql_secure_installation
sudo openssl dhparam -out /etc/nginx/ssl/dhparam.pem 2048


