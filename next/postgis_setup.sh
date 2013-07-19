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
psql -d template_postgis -c "CREATE EXTENSION hstore;"
psql -d template_postgis -f /usr/share/postgresql/9.1/contrib/postgis-1.5/postgis.sql
psql -d template_postgis -f /usr/share/postgresql/9.1/contrib/postgis-1.5/spatial_ref_sys.sql

# create databases
psql -c "CREATE DATABASE next OWNER next TEMPLATE=template_postgis;" 

psql -d next -c "ALTER TABLE geometry_columns OWNER TO next;" 
psql -d next -c "ALTER TABLE spatial_ref_sys OWNER TO next;" 
