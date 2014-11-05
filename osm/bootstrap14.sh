#!/bin/bash

sudo apt-get update

# install dependencies
sudo apt-get -y install ruby1.9.3 libruby ruby-dev ri libmagickwand-dev libxml2-dev libxslt1-dev nodejs apache2 apache2-threaded-dev build-essential git-core postgresql postgresql-contrib libpq-dev postgresql-server-dev-all libsasl2-dev openjdk-7-jre osmosis 

# update gems
sudo gem install bundler
