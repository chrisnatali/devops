#!/bin/bash

# setup requirements for next
# ONLY VALID FOR ubuntu 13.04 for now
# add ubuntugis repo for postgis2
sudo apt-get install -y software-properties-common # for add-apt-repository
sudo add-apt-repository -y ppa:ubuntugis/ubuntugis-unstable
# replace the distro
find /etc/apt/sources.list.d -type f | xargs sudo sed -i '/ubuntugis/s/raring/quantal/g'

sudo apt-get update

sudo apt-get -y install git python-pip python-dev python-virtualenv postgresql-server-dev-9.1 postgresql-contrib r-base libgdal1h libgeos-dev 
sudo apt-get -y install postgis postgresql-9.1-postgis-2.0 postgresql-9.1-postgis-2.0-scripts

# install sp package in R
wget http://cran.r-project.org/src/contrib/sp_1.0-11.tar.gz
sudo R CMD INSTALL sp_1.0-11.tar.gz

# install and create virtualenv(wrapper)
sudo pip install virtualenvwrapper

# Add virtualenvwrapper init script to bashrc
cat >> .bashrc << EOF
. `which virtualenvwrapper.sh`
EOF

# init it for the rest of this script
. `which virtualenvwrapper.sh`

mkvirtualenv next # from here on, working in next virtualenv

# clone NeXT repo
git clone https://github.com/modilabs/NeXT.git
cd NeXT
setvirtualenvproject # set the NeXT dir as the goto dir for next virtualenv

pip install -r requirements.txt
python setup.py develop

# TODO:  Add DB create/populate to separate script
# create db
# ./drop-and-create.sh next

# load db objects
# ./load-sql.sh

# add reference data
# paster import-fixtures development.ini fixtures.yaml

wget http://openlayers.org/download/OpenLayers-2.11.zip
unzip -u OpenLayers-2.11.zip

pushd OpenLayers-2.11/build
./build.py

popd

mkdir -p next/static/openlayers

cp -R OpenLayers-2.11/img next/static/openlayers
cp -R OpenLayers-2.11/theme next/static/openlayers
cp OpenLayers-2.11/build/OpenLayers.js next/static/openlayers
