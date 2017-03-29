class nginx {
  case $::osfamily {
    'redhat', 'debian' : {
      $package = 'nginx'
      $owner = 'root'
      $group = 'root'
      $docroot = '/var/www'
      $confdir = '/etc/nginx'
    }
    'windows' : {
      $package = 'nginx-service'
      $owner = 'Administrator'
      $group = 'Administrators'
      $docroot = 'C:/ProgramData/nginx/html'
      $confdir = 'C:/ProgramData/nginx/conf'
    }
  }
  File {
    owner => $owner,
    group => $group,
    mode  => '0664',
  }
  package { 'nginx':
    ensure => present,
    name   => $package,
  }
  file { $docroot:
    ensure => directory,
  }
  file { 'index.html':
    ensure => file,
    path   => "${docroot}/index.html",
    source => 'puppet:///modules/nginx/index.html',
  }
  file { 'nginx.conf':
    ensure  => file,
    path    => "${confdir}/nginx.conf",
    source  => "puppet:///modules/nginx/${::osfamily}.conf",
    require => Package['nginx'],
  }
  service { 'nginx':
    ensure    => running,
    enable    => true,
    subscribe => File['nginx.conf'],
  }
}
