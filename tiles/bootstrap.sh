#!/bin/bash

# setup requirements for tile server
sudo apt-get -y install git python-pip python-dev postgresql-server-dev-9.1 postgresql-9.1-postgis osm2pgsql postgresql-contrib

# clone tilestache & mapnik-stylesheets
git clone https://github.com/modilabs/TileStache.git
git clone https://github.com/modilabs/mapnik-stylesheets.git

# Mapnik requires some special setup that may change.
# See:  https://github.com/mapnik/mapnik/wiki/UbuntuInstallation
sudo apt-get install -y python-software-properties
sudo add-apt-repository ppa:mapnik/v2.2.0
sudo apt-get install libmapnik mapnik-utils python-mapnik

# python tools for tile server
sudo pip install -U pillow modestmaps simplejson werkzeug GDAL

# For gdal which the vector tiles tilestache provider requires
echo "\r" | sudo apt-add-repository ppa:ubuntugis/ubuntugis-unstable
sudo apt-get update
sudo apt-get install -y python-gdal
