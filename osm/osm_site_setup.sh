#!/bin/bash
# Install OSM site

# Get the openstreetmap website
if [ ! -d $HOME/openstreetmap-website ]
then
  git clone git@github.com:SEL-Columbia/openstreetmap-website.git
  # checkout big_merge branch temporarily
  cd openstreetmap-website
  git checkout big_merge
fi

# Make the libpgosm shared object lib
cd $HOME/openstreetmap-website/db/functions
make libpgosm.so
cd

