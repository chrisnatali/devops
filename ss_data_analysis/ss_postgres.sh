#!/bin/bash
# setup sharedsolar "data warehouse" 
# NOTE:  change passwords

sudo -u postgres -i

# create DB user and set password as needed
psql -c "CREATE ROLE sharedsolar SUPERUSER LOGIN PASSWORD 'sharedsolar';"
# create DB
psql -c "CREATE DATABASE sharedsolar OWNER sharedsolar;"
exit

# add .pgpass pwd file to eliminate password prompt for user
sudo -u sharedsolar -i
echo "*:*:*:sharedsolar:sharedsolar" > .pgpass
chmod 600 .pgpass
exit


