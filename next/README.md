Setup NeXT application

This assumes the target server has been setup with Ubuntu 13.04 appropriately

Running the following commands from the parent folder will setup the target
server to run NeXT:

# Setup server baseline user with sudo and libs
ssh <server> USER_NAME='next' USER_PWD='<pwd>' bash -s < bootstrap.sh

# Setup NeXT specific libs/apps
ssh <server_as_next_user> bash -s < next/bootstrap.sh

# Setup postgis template
ssh <server> bash -s < postgis_template_setup.sh

# Setup next db role
ssh <server_as_next_user> OS_USER=next DB_USER=next DB_PWD=<next_pwd> bash -s < postgres_role_setup.sh

# Setup postgis db for NeXT
ssh <server_as_next_user> DB_USER=next DB_NAME=next bash -s < next/postgis_db_setup.sh

# Finish up NeXT install (now that all components are in place)
ssh <server_as_next_user> bash -s < next/post_install.sh

# (optional) Setup up and run via apache/modwsgi
# NOTE:  'sudo bash -s' runs entire script as root
ssh <server> 'sudo bash -s' < apache_modwsgi.sh
