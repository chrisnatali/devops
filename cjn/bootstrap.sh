#!/bin/bash
# setup server for cjn
# Run as cjn user

# Install git, nginx
sudo apt-get -y install git-core nginx-full

# update config
sudo rm /etc/nginx/sites-available/default

