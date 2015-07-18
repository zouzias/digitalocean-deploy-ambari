# Install Apache Ambari server-client on Digitalocean

## Setup:

#### First, put your credentials in `config.rb`

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
fab init
```
### How to setup Apache ambari clients

```
fab clients bootstrap
```

## Requirements:

* Install Ruby
* Install python >= 2.7.
* Install fabric, i.e., `pip install fabric` (http://www.fabfile.org/en/latest/).


### Optional - Advanced

```
TODO : Cleanup deployment
```
