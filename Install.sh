#!/bin/bash

# Change the source.list
cp /etc/apt/sources.list /etc/apt/sources.list.bak
cat >sources.list <<EOL
deb http://mirrors.163.com/debian/ jessie main non-free contrib
deb http://mirrors.163.com/debian-archive/debian/ jessie-backports main non-free contrib
deb-src http://mirrors.163.com/debian/ jessie main non-free contrib
deb-src http://mirrors.163.com/debian-archive/debian/ jessie-backports main non-free contrib
deb http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib
deb-src http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib
EOL
cp sources.list /etc/apt/sources.list
rm sources.list

# Install basic softwares
apt -o Acquire::Check-Valid-Until=false update
apt install -y unzip
docker-php-ext-install mysqli

# Determine if the installation file exists
install_file="piwigo-2.10.1.zip"
if [ ! -f $install_file ]; then
    echo "Missing piwigo-2.10.1.zip"
    exit 1
fi

# Copy piwigo files to web root directory if /var/www/html/photo does not exist
unzip -n $install_file
rm -r /var/www/html
cp -r piwigo /var/www/html

# Change /var/www/html/ owner
chown -R www-data:www-data /var/www/html/
