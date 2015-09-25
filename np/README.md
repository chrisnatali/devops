Setup NetworkPlanner for running command line utils 

This assumes the target server has been setup with a Debian based distro

Running the following commands from the parent folder will setup the target
server to run NetworkPlanner command line utils:

# Setup server baseline user with sudo and libs
ssh <server> bash -s < bootstrap.sh

# Add user
ssh <server> USER_NAME='np' USER_PWD='<pwd>' bash -s < add_user.sh

# Setup NP specific libs/apps
ssh <server_as_np_user> bash -s < np/bootstrap.sh

