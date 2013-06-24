#!/bin/bash

# Sample environment params:
# AMI_ID=ami-eb22be8f
# KEY=modilabs
# SDA_SZ=128
# INSTANCE_NAME=my-instance
# IP=<your_ip_address>

# TODO:  Modify to check if instance exists (and use start) or is running (do nothing)
instanceid=`ec2-run-instances $AMI_ID -t t1.micro --key $KEY -g 'quicklaunch-1' -b '/dev/sda1=:'$SDA_SZ | grep INSTANCE | cut -f2`

# wait for instance to come up
echo "waiting for $instanceid to enter running state..."

while ! ec2-describe-instances $instanceid | grep -q running; do sleep 1; done

echo "$instanceid is running"

echo "assigning name osm"
ec2addtag $instanceid --tag Name=$INSTANCE_NAME

echo "assigning ip"
ipaddress="$IP"

ec2-associate-address -i "$instanceid" "$ipaddress"
