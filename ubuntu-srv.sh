#!/bin/bash

GREENCOLOR='\033[1;32m'
YELLOWCOLOR='\033[1;33m'
NC='\033[0m'

sudo service apache2 stop
sudo apt-get purge apache2 apache2-utils apache2.2-bin apache2-common
sudo apt-get -y autoremove
sudo service apache2 stop
sudo apt-get remove -y apache2*
sudo apt-get -y autoremove

printf "${GREENCOLOR}Nice And Clean,Let's Begin! ${NC} \n\n"

sudo apt-get update

sudo apt-get -y install zsh htop zip unzip composer

printf "${YELLOWCOLOR}Installing Language base ${NC} \n"

sudo LC_ALL=en_US.UTF-8 add-apt-repository ppa:nginx/development -y
sudo apt-get install -y language-pack-en-base
sudo apt-get -y install language-pack-zh-hans language-pack-zh-hans-base
sudo apt-get update

printf "${YELLOWCOLOR}Installing Tool base ${NC} \n"
sudo apt-get install -y build-essential dos2unix gcc git libmcrypt4 libpcre3-dev ntp unzip 
sudo apt-get install -y make python2.7-dev python-pip re2c supervisor unattended-upgrades whois vim
sudo apt-get install -y libnotify-bin
sudo apt-get install -y pv cifs-utils mcrypt bash-completion zsh
sudo apt-get install -y git
sudo apt-get update

printf "${YELLOWCOLOR}Installing Nginx ${NC} \n"
sudo apt-get -y install nginx
sudo service nginx start

printf "${GREENCOLOR}Adding PPA For PHP7.1 ${NC} \n\n"

sudo LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php -y
sudo apt-get update

printf "${GREENCOLOR}Successfully Added PPA For PHP7.1 ${NC} \n\n"

printf "${YELLOWCOLOR}Installing PHP7.1 And PHP7.1-FPM ${NC} \n"
sudo apt-get -y install php7.1
sudo apt-get -y install --allow-downgrades --allow-remove-essential --allow-change-held-packages
sudo apt-get -y install php7.1-cli php7.1-dev 
sudo apt-get -y install php7.1-mysql php7.1-imap
sudo apt-get -y install php7.1-fpm
sudo apt-get -y install php7.1-curl php7.1-xml php7.1-json php7.1-gd php7.1-mbstring php7.1-bcmath php7.1-zip
sudo apt-get -y install php7.1-intl php7.1-readline php-xdebug php-pear php-gettext
printf "${GREENCOLOR}Successfully Installed PHP7.1 And PHP7.1-FPM ${NC} \n\n"

printf "${YELLOWCOLOR}Configuring PHP7.1-FPM ${NC} \n"
sudo service php7.1-fpm restart

sudo service apache2 stop
sudo apt-get purge apache2 apache2-utils apache2.2-bin apache2-common
sudo apt-get remove -y apache2*
sudo apt-get -y autoremove

sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak

printf "${YELLOWCOLOR}Installing Certbot ${NC} \n"
sudo apt install software-properties-common
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update
sudo apt-get install python-certbot-nginx

printf "${YELLOWCOLOR}Installing Composer ${NC} \n"
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
printf "\nPATH=\"$(sudo su - www -c 'composer config -g home 2>/dev/null')/vendor/bin:\$PATH\"\n" | tee -a /home/www/.profile

printf "${YELLOWCOLOR}Installing Laravel Envoy & Installer ${NC} \n"
composer global require "laravel/envoy=~1.0"
composer global require "laravel/installer=~1.1"

printf "${YELLOWCOLOR}Installing PhpMyAdmin ${NC} \n"
sudo apt-get -y install phpmyadmin
sudo ln -s /usr/share/phpmyadmin /home/www/db

printf "${GREENCOLOR}Everything is all set! ${NC} \n\n"