#!/usr/bin/ruby

# Creates a droplet with domain name prefix equal to each line on file `ambari-client.txt`
#
#
# Important : Droplet RAM must be >= 8gb (if use hive/hdfs/spark)

image  = 'ubuntu-12-04-x64'
region = 'fra1'
size   = '8gb'
sshkey = 726646
domain = 'zouzias.org'	/* You domain name*/

# Install with 'gem install droplet_kit'
require 'droplet_kit'
require './config.rb'
require './droplet_commons.rb'

# Connection client
client = DropletKit::Client.new(access_token: @docean_token_v2)

# Select name
puts "Reading clients from abmari-clients.txt"
File.readlines('ambari-clients.txt').each do |name|

# Remove \n
name = name.chomp

puts "Selected region      : " + region
puts "Selected size        : " + size
puts "Selected key         : " + sshkey.to_s
puts "Selected droplet name: [" + name  + "]"

# TODO fetch SSH keys from digitalocean
droplet = DropletKit::Droplet.new(name: name + "." + domain , region: region, size: size, image: image, ssh_keys: [sshkey.to_s])

created = client.droplets.create(droplet)

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

created = client.domain_records.create(domain_record, for_domain: domain)
print created.inspect


end
