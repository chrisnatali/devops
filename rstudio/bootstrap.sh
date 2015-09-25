#!/bin/bash

# setup requirements for r-studio server
# TODO:  Update to install r-base for 3.0.3 (via updated sources.list)
sudo apt-get -y install r-base
sudo apt-get -y install gdebi-core
sudo apt-get -y install libapparmor1  # Required only for Ubuntu, not Debian
wget https://download2.rstudio.org/rstudio-server-0.99.473-amd64.deb
sudo gdebi -n rstudio-server-0.99.473-amd64.deb
sudo apt-get -y install git

sudo apt-get -y install libcurl4-openssl-dev
sudo apt-get -y install libgdal-dev
