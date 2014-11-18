#!/bin/bash

# Assumes postgis db has been setup and osm2pgsql has been installed

# setup osm-utils
sudo apt-get -y install ruby-dev
git clone https://github.com/chrisnatali/osm-utils.git
gem install --user-install nokogiri

# TODO:  
# - Update osm-utils/sync_load_cfg.rb to point to api server
# - add cronjob to update tile db:
#   crontab -u tiles osm-utils/sync_tile_db.crt

