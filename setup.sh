#!/bin/bash
webminversion="1.660"
owncloudversion="6.0.0a"

echo "Welcome at the Raspberry Pi NAS Installer!"
echo "This Packages will be installed:"
echo "- Webmin"
echo "- Apache"
echo "- php"
echo "- MySQL"
echo "- OwnCloud 6"
echo "- Samba"
echo " "

echo "Install Webmin"
wget http://garr.dl.sourceforge.net/project/webadmin/webmin/${webminversion}/webmin_${webminversion}_all.deb
dpkg -i webmin_${webminversion}_all.deb
apt-get --force-yes install -f

echo "Webserver, php, database and OwnCloud Install"
apt-get --force-yes install apache2 php5 php5-gd php-xml-parser php5-intl
apt-get --force-yes install php5-sqlite php5-mysql smbclient curl libcurl3 php5-curl
apt-get --force-yes install mysql-server mysql-client
cd /var/www
wget http://download.owncloud.org/community/owncloud-${owncloudversion}.tar.bz2
tar -xjf owncloud-${owncloudversion}.tar.bz2

echo "Samba Install"
apt-get --force-yes install samba

echo "Server config"
useradd nas
passwd nas
usermod -aG www-data nas
smbpasswd -a nas
chmod 774 /var/www/owncloud/data/nas/files
rm /etc/samba/smb.conf
wget https://raw.github.com/shaunjanssens/rpi-raid-owncloud-nas/master/smb.conf
cp smb.conf /etc/samba
service samba restart

