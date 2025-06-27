#!/bin/bash
echo "Installing MySQL..."

sudo apt-get update
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password rootpass'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password rootpass'
sudo apt-get install -y mysql-server

# Configure DB
mysql -u root -prootpass <<EOF
CREATE DATABASE taskdb;
CREATE USER 'taskuser'@'%' IDENTIFIED BY 'taskpass';
GRANT ALL PRIVILEGES ON taskdb.* TO 'taskuser'@'%';
FLUSH PRIVILEGES;
EOF

# Allow external connections (from app VM)
sudo sed -i 's/bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql
