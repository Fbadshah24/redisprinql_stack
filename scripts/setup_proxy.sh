#!/bin/bash
echo "Installing Nginx..."

sudo apt-get update
sudo apt-get install -y nginx

# Configure reverse proxy
sudo bash -c 'cat > /etc/nginx/sites-available/taskapp <<EOF
server {
    listen 80;

    location / {
        proxy_pass http://192.168.56.12:8080;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
}
EOF'

sudo ln -s /etc/nginx/sites-available/taskapp /etc/nginx/sites-enabled/taskapp
sudo rm /etc/nginx/sites-enabled/default
sudo systemctl restart nginx
