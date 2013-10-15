Setup Shared Solar Data Analysis environment

This assumes the target server has been setup with Ubuntu 12.04 appropriately

Running the following commands from the parent folder will setup the target
server as a Shared Solar data analysis environment:

# Setup server baseline user with sudo and libs
ssh <server> bash -s < bootstrap.sh
ssh <server> USER_NAME='ss' USER_PWD='<pwd>' bash -s < add_user.sh

# Setup ss specific libs/apps
ssh <server_as_ss_user> bash -s < ss_data_analysis/bootstrap.sh

# Setup ss data warehouse
ssh <server> bash -s < ss_data_analysis/ss_postgres.sh
