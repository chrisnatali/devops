#!/bin/bash

# setup requirements for shared solar data analysis
# ONLY VALID FOR ubuntu 12.04 for now

sudo apt-get -y install git python-all-dev postgresql postgresql-contrib

## clone ss_data_analysis repo
git clone git@github.com:modilabs/shared_solar_data_warehouse.git
