#!/bin/bash
# install anaconda for python2 and python3
# TODO:  Test if batch mode adds conda path to profile
#        if so, remove it
#
# once installed, to use add conda to the path via:
# export PATH="/home/username/anaconda[23]/bin:$PATH"

wget http://repo.continuum.io/archive/Anaconda2-4.0.0-Linux-x86_64.sh
bash Anaconda2-4.0.0-Linux-x86_64.sh -b

wget http://repo.continuum.io/archive/Anaconda3-4.0.0-Linux-x86_64.sh
bash Anaconda3-4.0.0-Linux-x86_64.sh -b
