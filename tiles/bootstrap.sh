#!/bin/bash

# setup everything required for tile server
sudo apt-get -y install git python-pip postgresql-server-dev-9.1 postgresql-9.1-postgis osm2pgsql postgresql-contrib
sudo pip install -U PIL modestmaps simplejson werkzeug 

# clone tilestache
git clone https://github.com/migurski/TileStache.git

# Mapnik requires some special setup that may change.
# See:  https://github.com/mapnik/mapnik/wiki/UbuntuInstallation
sudo apt-get install -y python-software-properties
sudo add-apt-repository ppa:mapnik/v2.2.0
sudo apt-get install libmapnik mapnik-utils python-mapnik
