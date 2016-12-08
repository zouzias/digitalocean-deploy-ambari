from fabric.api import env
from fabric.operations import run, put, sudo,local

#env.use_ssh_config = True

# CHANGE ME (change your SSH key)
env.user  = 'root'
env.key_filename = '~/.ssh/digitalocean_rsa'

domain = 'zouzias.org'

# Populate host names 
with open('ambari-server.txt') as f:
    env.hosts = f.readlines()[0].strip() + '.' + domain

#####################################
# Install Ambari Repo and Repo key  #
#####################################
def init():
    put('ambari.list', '/etc/apt/sources.list.d/', use_sudo=True)
    sudo('apt-key adv --recv-keys --keyserver keyserver.ubuntu.com B9733A7A07513CAD')
    apt_update()

def install_ambari_server():
    sudo('apt-get install -qy ambari-server')
    sudo('ambari-server setup --silent')
    stop_firewall()
    install_ntp()

def ambari_start():
    sudo('ambari-server start')

def ambari_status():
    sudo('ambari-server status')

def ambari_restart():
    sudo('ambari-server restart')

def clients():
    with open('ambari-clients.txt') as f:
	lines = f.readlines()
	env.hosts = []
	for line in lines:
	    env.hosts.append(line.strip() + '.' + domain)

def apt_clean():
    sudo('sudo dpkg --configure -a')

def apt_update():
    sudo('apt-get update')

def apt_upgrade():
    sudo('apt-get -qy upgrade')

def uptime():
    run('uptime')

def stop_firewall():
    run('ufw disable')

def install_ntp():
   sudo('apt-get install -y ntp')
   start_ntp

def install_ambari_agents():
   apt_update()
   sudo('apt-get install -y ambari-agent')

def start_ntp():
   sudo('service ntp restart')

# Reboot machines
def reboot():
    sudo('reboot')
