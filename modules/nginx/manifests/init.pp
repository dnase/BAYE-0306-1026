class nginx {
  package { 'nginx':
    ensure => present,
  }
  file { 'index.html':
    ensure => file,
    path   => '/var/www/index.html',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/nginx/index.html',
  }
  file { '/var/www':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
  file { 'nginx.conf':
    ensure  => file,
    path    => '/etc/nginx/nginx.conf',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
  }
  service { 'nginx':
    ensure    => running,
    enabled   => true,
    subscribe => File['nginx.conf'],
  }
}
