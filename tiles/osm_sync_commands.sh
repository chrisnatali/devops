#!/bin/bash

# Start with some OSM extract to populate OSM PostGIS DB 
# This example is of a Nigeria extract
wget http://download.geofabrik.de/africa/nigeria-latest.osm.pbf

# Populate a PostGIS DB with this extract 
osm2pgsql --database osm_grid --style gridmaps_pgsql.style --slim nigeria-latest.osm.pbf --hstore-all --extra-attributes --cache-strategy sparse --cache 1200M

# osmosis commands to get latest data and filter by a region polygon file

# initialize osmosis "state" directory
osmosis --rrii workingDirectory=$HOME/.osmosis 
# OPTIONAL (sample files in this repo):
#  1. Modify configuration.txt to point to updated url and set maxInterval = 0 to get ALL updates
#  2. Add/Update state.txt with appropriate sequenceNumber/timestamp

# These commands could be put into a crontab to regularly sync the postgis db from OSM
# Get latest changes
osmosis --read-replication-interval workingDirectory=$HOME/.osmosis --simplify-change --write-xml-change changes.osc.gz

# Filter by bounding polygon
gunzip changes.osc.gz
osmconvert changes.osc -B=nigeria.poly --out-osc > nigeria-changes.osc

# Sync this data in a PostGIS DB
osm2pgsql --database osm_grid --style gridmaps_pgsql.style --slim nigeria-changes.osc --hstore-all --extra-attributes --cache-strategy sparse --cache 1200M --append


