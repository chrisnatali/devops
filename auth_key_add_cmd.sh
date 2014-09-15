#!/bin/bash

# Example parameters:
# PUB_KEY_FILE=~/.ssh/id_rsa.pub
# SSH_CONN='vm_tiles'
# AUTH_KEYS='/home/tiles/.ssh/authorized_keys'
# USER_NAME=tiles

scp $PUB_KEY_FILE $SSH_CONN:.
local_pub_key=$(basename $PUB_KEY_FILE)
ssh $SSH_CONN "sudo mkdir -p \$(dirname $AUTH_KEYS);sudo chmod 777 \$(dirname $AUTH_KEYS);sudo cat $local_pub_key >> $AUTH_KEYS;sudo chown -R $USER_NAME:$USER_NAME \$(dirname $AUTH_KEYS);sudo chmod 700 \$(dirname $AUTH_KEYS);sudo chmod 600 $AUTH_KEYS;sudo rm $local_pub_key"
