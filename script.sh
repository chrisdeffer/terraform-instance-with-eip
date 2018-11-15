#!/bin/bash
sudo apt-get update -y
sudo apt-get install apache2 -y

 
mkfs -t ext4 /dev/xvdg
mkdir /opt/mount1
mount /dev/xvdg /opt/mount1
echo /dev/xvdg  /opt/mount1 ext4 defaults,nofail 0 2 >> /etc/fstab

sudo cp /var/www/html/index.html /var/www/html/index.html.orig
sudo rm /var/www/html/index.html
sudo mkdir -p /opt/mount1/apache/html
sudo echo "<html><body>Hello AWS World!</body></html>" >> /opt/mount1/apache/html/index.html
sudo touch /opt/mount1/apache/html/screenshot1.png
sudo touch /opt/mount1/apache/html/screenshot2.png
sudo ln -s /opt/mount1/apache/html/index.html /var/www/html/index.html
sudo ln -s /opt/mount1/apache/html/screenshot1.png /var/www/html/screenshot1.png
sudo ln -s /opt/mount1/apache/html/screenshot2.png /var/www/html/screenshot2.png
