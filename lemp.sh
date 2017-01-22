#!/bin/bash
# Automated LEMP installer for Ubuntu 16.04+
echo This script will install the LEMP Stack
sudo apt-get install nginx -y
# wget config then cp the file

cp default /etc/nginx/sites-available/default
sudo openssl dhparam -out /etc/nginx/ssl/dhparam.pem 2048
sudo nginx -t
sudo apt install php7.0 php7.0-fpm -y
sudo systemctl start php7.0-fpm
sudo systemctl restart nginx.service
sudo apt install php7.0-mcrypt php7.0-mbstring -y
sudo systemctl restart php7.0-fpm.service
sudo apt install mariadb-server mariadb-client php7.0-mysql -y
sudo systemctl restart php7.0-fpm.service
sudo mysql_secure_installation


