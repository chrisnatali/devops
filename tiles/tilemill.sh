#!/bin/bash

sudo apt-get -y install git nodejs-legacy npm
git clone https://github.com/mapbox/tilemill.git
cd tilemill
npm install 

# start tilemill via:
# ./index.js --config=config.json
