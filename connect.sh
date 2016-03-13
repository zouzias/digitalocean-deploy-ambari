#!/bin/bash

# Connect to the ambari-server droplet

# IMPORTANT: Update the SSH key below

HOST=`cat ambari-server.txt`
DOMAIN="zouzias.org"
USER=$(whoami)
KEY="/Users/${USER}/.ssh/digitalocean_rsa"

echo "KEY ${KEY}"
echo "USER ${USER}"
echo "HOST ${HOST}"
echo "DOMAIN ${DOMAIN}"

ssh -i ${KEY}  root@${HOST}.${DOMAIN}

