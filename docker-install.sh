#!/bin/bash
# install docker and docker-compose
# run as root

if ! which docker; then 
    curl -L https://get.docker.com/ | sh
fi

curl -L https://github.com/docker/compose/releases/download/1.7.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
