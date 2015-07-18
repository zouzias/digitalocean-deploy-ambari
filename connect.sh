#!/bin/bash

# Connect to the ambari-server droplet

# IMPORTANT: Update the SSH key below

HOST=`cat ambari-server.txt`
KEY='/Users/zouzias/.ssh/digitalocean_rsa'

echo "KEY ${KEY}"
echo "HOST ${HOST}"

ssh -i ${KEY}  root@${HOST}

