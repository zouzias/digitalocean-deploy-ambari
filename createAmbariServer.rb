#!/usr/bin/env ruby


# Create a droplet with FQDN the contents of ambari-server.txt appended with @domain variable below. Adds also a A record DNS entry.


image  = 'ubuntu-14-04-x64'
region = 'fra1'
size   = '512m'

# Install with 'gem install droplet_kit'
require 'droplet_kit'
require './config.rb'
require './droplet_commons.rb'

# Connection client
client = DropletKit::Client.new(access_token: @docean_token_v2)

# Select name
puts "Reading name from abmari-server.txt"
file = File.open("ambari-server.txt", "r")
name = file.read.chomp
file.close()

puts "Selected region      : " + region
puts "Selected size        : " + size
puts "Selected key         : " + @sshkey.to_s
puts "Selected droplet name: [" + name + "]"

# TODO fetch SSH keys from digitalocean
droplet = DropletKit::Droplet.new(name: name + "." + @domain , region: region, size: '512mb', image: image, ssh_keys: [@sshkey.to_s])

created = client.droplets.create(droplet)

print created.inspect

droplet_id = created.id

while created.status != 'active' do
	sleep 1
	print "."
	created = client.droplets.find(id: droplet_id)
end

puts created.inspect
puts "Droplet created with IP " + created.networks.v4[0].ip_address

ip = created.networks.v4[0].ip_address

print "IP address is " + ip

domain_record = DropletKit::DomainRecord.new(
  type: 'A',
  name: name,
  data: ip,
)

created = client.domain_records.create(domain_record, for_domain: @domain)
print created.inspect
