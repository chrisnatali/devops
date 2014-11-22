#!/bin/bash
# Setup tilestache to run on apache2
# run as tiles user

# First install apache2 and mod_python
sudo apt-get install -y apache2 libapache2-mod-wsgi

# Run apache as tiles user
sudo sed -i 's/www-data/tiles/' /etc/apache2/envvars

# Configure osm site in apache
sudo su
cat - > /etc/apache2/sites-available/tiles.conf << EOF
<VirtualHost *:80>
  #ServerName tiles.server.org
  WSGIScriptAlias /tilestache /home/tiles/TileStache/stash-gridmaps.wsgi
  DocumentRoot /home/tiles/TileStache

  <Directory /home/tiles/TileStache>
    Allow from all
    Options -MultiViews
    Require all granted
  </Directory>

  ErrorLog /var/log/apache2/error.log
  CustomLog /var/log/apache2/access.log combined

</VirtualHost>
EOF

rm /etc/apache2/sites-enabled/tiles.conf
ln -s /etc/apache2/sites-available/tiles.conf /etc/apache2/sites-enabled/tiles.conf

service apache2 restart
exit
