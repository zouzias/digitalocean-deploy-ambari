include java,git

class { 'apt':  
    always_apt_update => true,
}

exec { 'apt-get-update':  
    command     => '/usr/bin/apt-get update',
    refreshonly => true,
}

package { "ambari-server":
  ensure => installed,
  require    => Exec['apt-get-update'],
}

