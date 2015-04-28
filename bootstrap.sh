#!/usr/bin/env bash

sudo apt-get update
sudo apt-get -y upgrade

# Apache and PHP5
sudo apt-get install -y apache2
sudo apt-get install -y php5

# Enable PHP5 JSON
sudo apt-get install php5-json
sudo php5enmod json
sudo service apache2 restart

# Silent MySQL Install 
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password"
sudo apt-get -y install mysql-server
sudo apt-get install php5-mysql

# PHP tweaks
sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 20M/g" /etc/php5/apache2/php.ini
sed -i "s/post_max_size = 8M/post_max_size = 80M/g" /etc/php5/apache2/php.ini

# Install Adminer
wget http://www.adminer.org/latest.php
mkdir /var/www/html/adminer
mv latest.php /var/www/html/adminer/index.php
chmod 755 /var/www/html/adminer/index.php

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
sudo apt-get -y install git

# Install Composer
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
