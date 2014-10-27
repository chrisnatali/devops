#!/bin/bash

# setup requirements for tile server
sudo apt-get -y install git curl tmux postgresql-9.3 postgresql-9.3-postgis-2.1 osm2pgsql python-dev libgeos-dev

# specific to tilestache
sudo apt-get install -qq gdal-bin memcached python-pip
sudo apt-get install -qq python-imaging python-memcache python-gdal
sudo apt-get install -qq python-werkzeug python-psycopg2 python-mapnik gunicorn

# tilestache repo with local config
git clone https://github.com/SEL-Columbia/TileStache.git
# set it up
cd TileStache
sudo pip install -r requirements.txt

