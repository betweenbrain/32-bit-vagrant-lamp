#!/usr/bin/env bash

sudo apt-get update
sudo apt-get -y dist-upgrade

# Apache
sudo apt-get install -y apache2

# Set server name to calm output
sudo echo "ServerName localhost" > /etc/apache2/conf-available/httpd.conf
sudo a2enconf httpd

# PHP5
sudo apt-get install -y php5

# Enable PHP5 JSON
sudo apt-get install -y php5-json
sudo php5enmod json

# Install cURL
sudo apt-get install -y curl libcurl3 libcurl3-dev php5-curl

# Silent MySQL Install
# http://stackoverflow.com/questions/7739645/install-mysql-on-ubuntu-without-password-prompt#comment37966911_7740393
export DEBIAN_FRONTEND=noninteractive
sudo -E apt-get install -q -y mysql-server-5.5
sudo apt-get install -y php5-mysql

# PHP tweaks
sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 20M/g" /etc/php5/apache2/php.ini
sed -i "s/post_max_size = 8M/post_max_size = 80M/g" /etc/php5/apache2/php.ini

# Install Adminer
wget http://www.adminer.org/latest.php
mkdir /var/www/html/adminer
mv latest.php /var/www/html/adminer/index.php
chmod 755 /var/www/html/adminer/index.php

# Remove default index.html file
rm /var/www/html/index.html

# setup hosts file
VHOST=$(cat <<EOF
<VirtualHost *:80>
    DocumentRoot "/var/www/html"
    <Directory "/var/www/html">
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-available/000-default.conf

# enable mod_rewrite
sudo a2enmod rewrite

# restart apache
sudo service apache2 restart

# install git
sudo apt-get install -y git

# Install Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
