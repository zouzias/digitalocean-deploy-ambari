# Install Apache Ambari server & clients on Digitalocean

This project installs ambari-server and also prepares droplets serving as clients for Ambari. It also adds FQDN for both server and clients.

This project assumes that you use [digitalocean](https://www.digitalocean.com/) and have setup a domain under digitalocean. This project is tested using Ubuntu 14.04 droplets.

### First, put your credentials in `config.rb`

Edit the following file accordingly:

```
#!/usr/bin/ruby

@docean_key       = 'your token api v2 key' // read from env `ENV['DIGOCEAN_TOKEN']`
@region = 'fra1'
@sshkey = XXX
@domain = 'zouzias.org'  # You domain name
@image  = 'ubuntu-14-04-x64'


#
## Important : Droplet RAM must be >= 8gb (if use hive/hdfs/spark)

@client_size   = '8gb'

```

#### SSH key for `fabric`

Change the following line in `fabfile.py` to point to the ssh key associated with the above VMs
`env.key_filename = '~/.ssh/digitalocean_rsa'` Also update the domain name.

#### Update hostname for clients and server

Update ambari-server.txt to your desired name for ambari-server.

Similary, change ambari-clients.txt to the desired hostname for all ambari clients. Each line will correspond to a new droplet!

### How to setup Apache ambari server

```
ruby createAmbariServer.rb
fab init                    # install ambari repo info
fab install_ntp             # install network time protocol
fab install_ambari_server   # install ambari-server package
fab ambari_start            # Start ambari-server process
```
Make sure that the ambari-server process is running (connect to server droplet using `./connect.sh`). The last step `fab ambari_start` might fail, you might need to connect to the droplet and start the server manually.

### How to setup Apache ambari clients

```
ruby createAmbariClients.rb
fab clients install_ntp  # install network time protocol
```

Then login on `ambari-server.your_domain_name.com:8080` with username/password admin/admin

## Requirements:

* Install Ruby and Ruby gems
* Install droplet_kit (gem install droplet_kit)
* Install python >= 2.7.
* Install fabric, i.e., `pip install fabric` (http://www.fabfile.org/en/latest/).


### Optional - Advanced

```
TODO : Cleanup deployment, i.e., provide clean up functionality after destroy of all droplets.
```
