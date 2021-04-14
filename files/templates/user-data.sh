#!/bin/bash

yum update -y

yum install httpd php php-mysql php-gd mariadb-server php-xml php-intl mysql wget amazon-linux-extras -y

amazon-linux-extras enable php7.4
yum clean metadata
yum install php php-{pear,cgi,common,curl,mbstring,gd,mysqlnd,gettext,bcmath,json,xml,fpm,intl,zip,imap} -y

systemctl restart httpd.service ; systemctl enable httpd.service
systemctl start mariadb ; systemctl enable mariadb

mysql -u root -e "CREATE USER 'wiki'@'localhost' IDENTIFIED BY '${password}';"
mysql -u root -e "CREATE DATABASE wikidatabase;"
mysql -u root -e "GRANT ALL PRIVILEGES ON wikidatabase.* TO 'wiki'@'localhost';"
mysql -u root -e "FLUSH PRIVILEGES;"

wget https://releases.wikimedia.org/mediawiki/1.35/mediawiki-1.35.1.tar.gz
wget https://releases.wikimedia.org/mediawiki/1.35/mediawiki-1.35.1.tar.gz.sig
gpg --verify mediawiki-1.35.1.tar.gz.sig mediawiki-1.35.1.tar.gz
tar -zxf mediawiki-1.35.1.tar.gz
mv mediawiki-1.35.1 /var/www/html/

cd /var/www/html/
ln -s mediawiki-1.35.1/ mediawiki
chown -R apache:apache /var/www/html/mediawiki-1.35.1
chmod 755 /var/www/html/mediawiki/

service httpd restart
