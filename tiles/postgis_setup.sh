#!/bin/bash

# add .pgpass pwd file to eliminate password prompt for tiles user
sudo -u tiles -i
echo "*:*:*:tiles:tiles" >> .pgpass
chmod 600 .pgpass
exit

sudo -u postgres -i

# create tiles user and set password
psql -c "CREATE ROLE tiles SUPERUSER LOGIN PASSWORD 'tiles';"

# setup postgis template db
createdb -E UTF8 template_postgis
createlang plpgsql template_postgis
psql -d template_postgis -c "CREATE EXTENSION hstore;"
psql -d template_postgis -f /usr/share/postgresql/9.1/contrib/postgis-1.5/postgis.sql
psql -d template_postgis -f /usr/share/postgresql/9.1/contrib/postgis-1.5/spatial_ref_sys.sql

# create databases
psql -c "CREATE DATABASE gis_pln OWNER tiles TEMPLATE=template_postgis;" 
psql -c "CREATE DATABASE gis_np OWNER tiles TEMPLATE=template_postgis;" 

psql -d gis_pln -c "ALTER TABLE geometry_columns OWNER TO tiles;" 
psql -d gis_pln -c "ALTER TABLE spatial_ref_sys OWNER TO tiles;" 
psql -d gis_np -c "ALTER TABLE geometry_columns OWNER TO tiles;" 
psql -d gis_np -c "ALTER TABLE spatial_ref_sys OWNER TO tiles;" 
