#!/bin/bash

if [ ! $DB_USER ] || [ ! $DB_NAME ]


then
    echo "usage: DB_USER=<db_user> DB_NAME=<db_name> postgis_db_setup.sh"
    exit 1
fi 

echo "setting up postgis DB with DB_USER=$DB_USER DB_NAME=$DB_NAME"

# assumes DB_USER has been created
sudo DB_USER=$DB_USER DB_NAME=$DB_NAME -u postgres -i

# create databases (assumes template_postgis has been created)
psql -c "CREATE DATABASE $DB_NAME OWNER $DB_USER TEMPLATE=template_postgis;" 

# these columns could belong to the DB_USER
psql -d $DB_NAME -c "ALTER TABLE geometry_columns OWNER TO $DB_USER;" 
psql -d $DB_NAME -c "ALTER TABLE spatial_ref_sys OWNER TO $DB_USER;" 
psql -d $DB_NAME -c "ALTER TABLE geography_columns OWNER TO $DB_USER;" 
