#!/bin/bash

# Install and setup apache + passenger to serve openstreetmap-website
# First apache2
apt-get install -y apache2
# Run apache as osm user
sed -i 's/www-data/osm/' /etc/apache2/envvars

# Configure osm site in apache
cat - > /etc/apache2/sites-available/osm << EOF
<VirtualHost *:80>
  DocumentRoot /home/osm/openstreetmap-website
  RailsEnv production

  Header set Access-Control-Allow-Origin "*"

  <Directory /home/user/openstreetmap-website/public>
    Allow from all
    Options -MultiViews
  </Directory>

  ErrorLog /var/log/apache2/error.log
  LogLevel warn
  CustomLog /var/log/apache2/access.log combined
</VirtualHost>
EOF

unlink /etc/apache2/sites-enabled/*
ln -s /etc/apache2/sites-available/osm /etc/apache2/sites-enabled/osm

# Setup passenger
apt-get -y install libcurl4-openssl-dev
gem install passenger
passenger-install-apache2-module -a

updatedb

cat - > /etc/apache2/conf.d/passenger << EOF
LoadModule passenger_module `locate mod_passenger.so | head -1`
PassengerRoot /var/lib/gems/1.9.1/gems/passenger-"`passenger --version | head -1 | awk '{print $4}'`"
PassengerRuby /usr/bin/ruby1.9.1
EOF

# precompile assets (js, etc)
cd /home/osm/openstreetmap-website/
bundle exec rake assets:precompile

service apache2 restart
