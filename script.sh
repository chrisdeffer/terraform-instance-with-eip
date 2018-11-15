#!/bin/bash
apt-get update -y
apt-get install apache2 -y
mkfs -t ext4 /dev/xvdg
mkdir /opt/mount1
mount /dev/xvdg /opt/mount1
echo /dev/xvdg  /opt/mount1 ext4 defaults,nofail 0 2 >> /etc/fstab
cp /var/www/html/index.html /var/www/html/index.html.orig
rm /var/www/html/index.html
mkdir -p /opt/mount1/apache/html
echo "<html><body>Hello AWS World!</body></html>" >> /opt/mount1/apache/html/index.html
touch /opt/mount1/apache/html/screenshot1.png
touch /opt/mount1/apache/html/screenshot2.png
ln -s /opt/mount1/apache/html/index.html /var/www/html/index.html
ln -s /opt/mount1/apache/html/screenshot1.png /var/www/html/screenshot1.png
ln -s /opt/mount1/apache/html/screenshot2.png /var/www/html/screenshot2.png
