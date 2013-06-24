#!/bin/bash

# Do everything as root (preserve env vars via -E)
sudo -E su

if [ -z $USER_NAME ]; then echo "Need to set USER_NAME"; fi
if [ -z $USER_PWD ]; then echo "Need to set USER_PWD"; fi

apt-get update

# ensure that the sudo group exists and has NOPASSWD sudo perms
groupadd sudo

grep -v '%sudo' /etc/sudoers > tmp.sudoers
echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> tmp.sudoers
cat tmp.sudoers > /etc/sudoers
rm tmp.sudoers

# add user (change pwd as needed)
if ! id -u $USER_NAME > /dev/null
then
    echo "adding user..."
    useradd -p $(perl -e'print crypt("'$USER_PWD'", "aa")') -s "/bin/bash" -U -m -G sudo $USER_NAME
else
    echo "user already exists"
fi
