#!/usr/bin/env ruby

# Assuming Digitalocean API v2.
@docean_token_v2 = ENV['DIGOCEAN_TOKEN'] # Token api v2

@region = 'fra1'
@sshkey = 726646
@domain = 'zouzias.org'  # You domain name
@image  = 'ubuntu-14-04-x64'


#
## Important : Droplet RAM must be >= 8gb (if use hive/hdfs/spark)

@client_size   = '8gb'
