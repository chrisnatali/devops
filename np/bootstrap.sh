#!/bin/bash

# setup system level packages
sudo apt-get -y install git python-pip python-dev libgdal-dev build-essential
# for scipy
sudo apt-get -y install gfortran libopenblas-dev liblapack-dev
# for geo stuff
sudo apt-get -y install python-gdal

# libspatialindex (only required for network model)
mkdir -p tmp
cd tmp
git clone git://github.com/libspatialindex/libspatialindex.git
sudo apt-get install -y automake libtool
(cd libspatialindex && ./autogen.sh && ./configure && make && sudo make install)
sudo ldconfig
cd

# git clone https://github.com/SEL-Columbia/networkplanner.git np
git clone git@github.com:SEL-Columbia/networkplanner.git np

# install virtualenv and virtualenvwrapper (see http://virtualenvwrapper.readthedocs.org)
# YMMV 
# This is optional if you don't mind intermingled python packages on your system
sudo apt-get -y install python-virtualenv
sudo pip install virtualenvwrapper
# setup your bashrc to source virtualenvwrapper
if ! grep 'virtualenvwrapper\.sh' .bashrc; 
then
cat >> .bashrc << EOF
. `which virtualenvwrapper.sh`
EOF
fi
. `which virtualenvwrapper.sh` # source it for the session (not needed for future sessions)
if ! workon np > /dev/null
then
    mkvirtualenv --system-site-packages np # from here on, working in np virtualenv
    cd np 
    setvirtualenvproject # from here on you can enter 'workon np' to work in the np virtualenv
fi

# setup project specific python packages
pip install -r requirements.txt

# only required for network model
pip install -r requirements_network.txt 
