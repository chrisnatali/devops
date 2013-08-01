#!/bin/bash

# add .pgpass pwd file to eliminate password prompt for next user
sudo -u next -i
echo "*:*:*:next:next" >> .pgpass
chmod 600 .pgpass
exit

sudo -u postgres -i

# create tiles user and set password
psql -c "CREATE ROLE next SUPERUSER LOGIN PASSWORD 'next';"

# setup postgis template db
createdb -E UTF8 template_postgis
createlang plpgsql template_postgis
psql -d template_postgis -c "CREATE EXTENSION postgis;"

# create databases
psql -c "CREATE DATABASE next OWNER next TEMPLATE=template_postgis;" 

# these columns could belong to next
psql -d next -c "ALTER TABLE geometry_columns OWNER TO next;" 
psql -d next -c "ALTER TABLE spatial_ref_sys OWNER TO next;" 
psql -d next -c "ALTER TABLE geography_columns OWNER TO next;" 
