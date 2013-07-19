#!/bin/bash

# setup requirements for next
sudo apt-get -y install git python-pip python-dev python-pastescript python-setuptools postgresql-server-dev-9.1 postgresql-9.1-postgis postgresql-contrib r-base

# clone NeXT repo
git clone https://github.com/modilabs/NeXT.git

cd NeXT
sudo pip install -r requirements.txt
python setup.py develop

# create db
./drop-and-create.sh next

# load db objects
./load-sql.sh

# add reference data
paster import-fixtures development.ini fixtures.yaml

wget http://openlayers.org/download/OpenLayers-2.11.zip
unzip -u OpenLayers-2.11.zip

pushd OpenLayers-2.11/build
./build.py

popd

mkdir -p next/static/openlayers

cp -R OpenLayers-2.11/img next/static/openlayers
cp -R OpenLayers-2.11/theme next/static/openlayers
cp OpenLayers-2.11/build/OpenLayers.js next/static/openlayers
