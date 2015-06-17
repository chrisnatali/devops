#!/bin/bash
# setup server for natalivineyards production
# Run as nv user
# mostly taken from:  https://gorails.com/deploy/ubuntu/14.04

# install req'd pkgs
sudo apt-get -y install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev libcurl4-openssl-dev python-software-properties nodejs

# install ruby via rbenv
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL

rbenv install 2.1.3
rbenv global 2.1.3

# install nginx and passenger
# Install Phusion's PGP key to verify packages
gpg --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
gpg --armor --export 561F9B9CAC40B2F7 | sudo apt-key add -

# Add HTTPS support to APT
sudo apt-get -y install apt-transport-https

# Add the passenger repository
sudo sh -c "echo 'deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main' >> /etc/apt/sources.list.d/passenger.list"
sudo chown root: /etc/apt/sources.list.d/passenger.list
sudo chmod 600 /etc/apt/sources.list.d/passenger.list
sudo apt-get update

# Install nginx and passenger
sudo apt-get -y install nginx-full passenger

# update config
sudo sed -i "s|# passenger_ruby.*|passenger_ruby `which ruby`;|" /etc/nginx/nginx.conf
sudo sed -i 's/# passenger_root/passenger_root/' /etc/nginx/nginx.conf
sudo rm /etc/nginx/sites-available/default

# install bundler so that capistrano can do the rest
gem install bundle

