#!/bin/bash

# init virtualenv stuff for the rest of this script
. `which virtualenvwrapper.sh`

workon next

# setup reference data
paster import-fixtures production.ini fixtures.yaml

# load stored procs/triggers
./load-sql.sh next
