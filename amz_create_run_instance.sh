#!/bin/bash

# Sample environment params:
# AMI_ID=ami-23d9a94a
# KEY=modilabs
# SDA_SZ=128
# INSTANCE_NAME=my-instance
# SECURITY_GROUP=<security-group>

# TODO:  Modify to check if instance exists (and use start) or is running (do nothing)
instanceid=`ec2-run-instances $AMI_ID -t t1.micro --key $KEY -g $SECURITY_GROUP -b '/dev/sda1=:'$SDA_SZ | grep INSTANCE | cut -f2`

# wait for instance to come up
echo "waiting for $instanceid to enter running state..."

while ! ec2-describe-instances $instanceid | grep -q running; do sleep 1; done

echo "$instanceid is running"

echo "assigning name"
ec2addtag $instanceid --tag Name=$INSTANCE_NAME

echo "done"

