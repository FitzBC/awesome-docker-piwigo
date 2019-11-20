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
apt install -y curl

# Import config file
. piwigo.config

bash wait-for-it.sh db:3306 -- echo 1 
bash wait-for-it.sh web:80 -- echo 2
# # Install piwigo
curl -i -s -k -X "POST" \
    --data-binary "language=zh_CN&dbhost=db&dbuser=${DB_USER}&dbpasswd=${DB_PASSWD}&dbname=${MAINDB}&prefix=piwigo_&admin_name=${admin_name}&admin_pass1=${admin_pass}&admin_pass2=${admin_pass}&admin_mail=${admin_mail}&install=%E5%BC%80%E5%A7%8B%E5%AE%89%E8%A3%85" \
    "http://web/install.php" > /var/1.txt
