#!/bin/bash

# Requires:
# INSTANCE_ID=<instance-id>
# IP=<ip_address>
echo "assigning ip"

ec2-associate-address -i "$INSTANCE_ID" "$IP"

echo "done"
