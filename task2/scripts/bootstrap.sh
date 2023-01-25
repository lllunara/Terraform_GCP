#!/bin/bash
sudo su
apt update -y
apt install apache2 -y
systemctl start apache2
systemctl enable apache2
echo "startup script" > /var/www/html/index.html