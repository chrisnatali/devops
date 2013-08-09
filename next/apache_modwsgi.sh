#!/bin/bash
# Setup next to run on apache2

# First install apache2 and mod_python
apt-get install -y apache2 libapache2-mod-wsgi

# Run apache as next user
sed -i 's/www-data/next/' /etc/apache2/envvars

# Configure next site in apache
cat - > /etc/apache2/sites-available/next << EOF
WSGIPythonHome /home/next/.virtualenvs/next
<VirtualHost *:80>
  WSGIScriptAlias / /home/next/NeXT/next.wsgi
  DocumentRoot /var/www

  ErrorLog /var/log/apache2/error.log
  CustomLog /var/log/apache2/access.log combined

</VirtualHost>
EOF

unlink /etc/apache2/sites-enabled/*
ln -s /etc/apache2/sites-available/next /etc/apache2/sites-enabled/next

# remove the existing lock file created by root
rm -rf /var/lock/apache2

service apache2 restart
