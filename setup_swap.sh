#!/bin/bash

# allocate 4G of swap
dd if=/dev/zero of=/swapfile bs=1M count=4096

mkswap /swapfile
swapon /swapfile

# enable the swap on startup
echo "/swapfile swap swap defaults 0 0" >> /etc/fstab
