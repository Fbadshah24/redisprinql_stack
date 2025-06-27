#!/bin/bash
echo "Installing Redis..."

sudo apt-get update
sudo apt-get install -y redis-server

# Allow external access
sudo sed -i "s/^bind 127.0.0.1 ::1/# bind 127.0.0.1 ::1/" /etc/redis/redis.conf
sudo sed -i "s/^protected-mode yes/protected-mode no/" /etc/redis/redis.conf

sudo systemctl restart redis
