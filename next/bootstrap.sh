#!/bin/bash

# setup requirements for next
sudo apt-get -y install git python-pip python-dev python-pastescript python-setuptools postgresql-server-dev-9.1 postgresql-9.1-postgis postgresql-contrib r-base

# clone NeXT repo
git clone https://github.com/modilabs/NeXT.git
