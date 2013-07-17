#!/bin/bash
# Setup tilestache to run on apache2

# First install apache2 and mod_python
apt-get install -y apache2 libapache2-mod-wsgi

# Run apache as tiles user
sed -i 's/www-data/tiles/' /etc/apache2/envvars

# Configure osm site in apache
cat - > /etc/apache2/sites-available/tiles << EOF
<VirtualHost *:80>
  WSGIScriptAlias /tilestache /home/tiles/TileStache/stash.wsgi
  DocumentRoot /home/tiles/TileStache/www

  ErrorLog /var/log/apache2/error.log
  CustomLog /var/log/apache2/access.log combined

</VirtualHost>
EOF

unlink /etc/apache2/sites-enabled/*
ln -s /etc/apache2/sites-available/tiles /etc/apache2/sites-enabled/tiles

service apache2 restart
