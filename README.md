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

## How to setup Apache ambari

First, run the following fog script to create a VM under zc2 with hostname ambari.zouzias.org.

```
XXX
```

Then, Run ``fab init`` and ``fab deploy`` to install apache tomcat into the VMS.

## Requirements:

* Install Ruby
* Install python >= 2.7.
* Install fabric, i.e., `pip install fabric` (http://www.fabfile.org/en/latest/).


### Optional - Advanced

```
TODO : Cleanup deployment
```
