#!/bin/bash

# setup requirements for shared solar data analysis
# ONLY VALID FOR ubuntu 13.04 for now

sudo apt-get -y install git python-pip python-dev python-virtualenv 

# install and create virtualenv(wrapper)
sudo pip install virtualenvwrapper
sudo updatedb

# Add virtualenvwrapper init script to bashrc
cat >> .bashrc << EOF
. `which virtualenvwrapper.sh`
EOF

# init it for the rest of this script
. `which virtualenvwrapper.sh`

mkvirtualenv ss_data_analysis # from here on, working in ss_data_analysis virtualenv

# clone ss_data_analysis repo
git clone git@github.com:modilabs/ss_data_analysis.git
cd ss_data_analysis
setvirtualenvproject # set the ss_data_analysis dir as the goto dir for virtualenv

# install more specific project libs within virtualenv
pip install -r requirements.txt

