#!/bin/bash

# setup requirements for tile server
sudo apt-get -y install git curl tmux postgresql-9.3 postgresql-9.3-postgis-2.1 python-dev libgeos-dev
sudo apt-get -y install autoconf automake libtool make g++ libxml2-dev libgeos-dev
sudo apt-get -y install libgeos++-dev libpq-dev libbz2-dev libproj-dev protobuf-c-compiler
sudo apt-get -y install libprotobuf-c0-dev lua5.2 liblua5.2-dev

# For osm data sync we use osmosis and osm2pgsql and osmconvert (in osmctools)
# build osm2pgsql to get the latest since apt pkg version doesn't apply data diffs
git clone https://github.com/openstreetmap/osm2pgsql.git
cd osm2pgsql
./autogen.sh
./configure && make
sudo make install
cd

sudo apt-get install osmosis osmctools

# specific to tilestache
sudo apt-get install -qq gdal-bin memcached python-pip
sudo apt-get install -qq python-imaging python-memcache python-gdal
sudo apt-get install -qq python-werkzeug python-psycopg2 python-mapnik gunicorn

# tilestache repo with local config 
git clone https://github.com/SEL-Columbia/TileStache.git
# set it up
cd TileStache
sudo pip install -r requirements.txt

