#!/bin/bash

# install dependencies
apt-get -y install ruby1.9.3 libmagickwand-dev libxml2-dev libxslt1-dev apache2 apache2-threaded-dev build-essential git-core postgresql postgresql-contrib libpq-dev postgresql-server-dev-9.1 libsasl2-dev openjdk-7-jre osmosis 

# update gems
gem install bundler
