#!/usr/bin/env bash


MY_USER="$(logname)"
echo "Running as: $MY_USER, with sudo privileges."


# Update package list
apt update

# Update system packages
apt -y upgrade

apt install -y software-properties-common curl
apt-add-repository ppa:nginx/development -y
apt-add-repository ppa:ondrej/php -y

curl -sL https://deb.nodesource.com/setup_12.x | bash -

# Update package lists
apt update

# Install some basic packages
apt install -y dos2unix git libmcrypt4

# Install PHP stuffs
apt install -y php7.4-cli php7.4 \
php7.4-pgsql php7.4-sqlite3 php7.4-gd \
php7.4-curl php7.4-memcached \
php7.4-imap php7.4-mysql php7.4-mbstring \
php7.4-xml php7.4-zip php7.4-bcmath php7.4-soap \
php7.4-intl php7.4-readline

# Install Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Install Apache
apt-get install -y --force-yes apache2

# Add your user to www-data
usermod -a -G www-data $MY_USER
id $MY_USER
groups $MY_USER	

# Transfer ownership of /var/www to your user
chown -R $MY_USER:www-data /var/www
chmod -R g+s /var/www

# Install Node and some Node packages
apt-get install -y nodejs
/usr/bin/npm install -g yarn

# Clean up
apt -y autoremove
apt -y clean



