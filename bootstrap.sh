#!/bin/bash

# Do everything as root (preserve env vars via -E)
sudo -E su

apt-get update

# ensure that the sudo group exists and has NOPASSWD sudo perms
groupadd sudo

grep -v '%sudo' /etc/sudoers > tmp.sudoers
echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> tmp.sudoers
cat tmp.sudoers > /etc/sudoers
rm tmp.sudoers

