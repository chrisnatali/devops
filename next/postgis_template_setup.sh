#!/bin/bash

sudo -u postgres -i

# setup postgis template db
createdb -E UTF8 template_postgis
createlang plpgsql template_postgis
psql -d template_postgis -c "CREATE EXTENSION postgis;"

