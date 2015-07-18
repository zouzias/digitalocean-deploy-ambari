# Install Apache Ambari server & clients on Digitalocean

### First, put your credentials in `config.rb`

Edit the following file accordingly:

```
#!/usr/bin/ruby

@docean_key       = 'your token api v2 key'
```

#### SSH key for `fabric`

Change the following line in `fabfile.py` to point to the ssh key associated with the above VMs. 
`env.key_filename = '~/.ssh/digitalocean_rsa'`

#### Update hostname for clients and server

Update ambari-server.txt to your desired name for ambari-server. Also change the the `domain` variable on createAmbariServer.rb to your domain name (currently `zouzias.org`)

Similary, change ambari-clients.txt to the desired hostname for all ambari clients. Each line will correspond to a new droplet! Also change the the `domain` variable on createAmbariClients.rb to your domain name (currently `zouzias.org`)

### How to setup Apache ambari server

```
ruby createAmbariServer.rb
fab install_ntp             # install network time protocol
fab init                    # install ambari-server package
fab ambari_start            # Start ambari-server process
```
Make sure that the ambari-server process is running (connect to server droplet using `./connect.sh`)

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
TODO : Cleanup deployment
```
