class nginx {
  case $::osfamily {
    'redhat', 'debian' : {
      $package = 'nginx'
      $owner = 'root'
      $group = 'root'
      $docroot = '/var/www'
      $confdir = '/etc/nginx'
      $logdir = '/var/log'
    }
    'windows' : {
      $package = 'nginx-service'
      $owner = 'Administrator'
      $group = 'Administrators'
      $docroot = 'C:/ProgramData/nginx/html'
      $confdir = 'C:/ProgramData/nginx/conf'
      $logdir = 'C:/Wherever'
    }
  }
  $user = $::osfamily ? {
    'windows' => 'nobody',
    'debian'  => 'www-data',
    'redhat'  => 'nginx',
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
  nginx::vhost { 'default':
    docroot     => $docroot,
    server_name => $::fqdn,
  }
  file { "${docroot}/vhosts":
    ensure => directory,
  }
  file { 'nginx.conf':
    ensure    => file,
    path      => "${confdir}/nginx.conf",
    content   => epp('nginx/nginx.conf.epp', {
      docroot => $docroot,
      logdir  => $logdir,
      confdir => $confdir,
      user    => $user,
    }),
    require => Package['nginx'],
    notify  => Service['nginx'],
  }
  service { 'nginx':
    ensure    => running,
    enable    => true,
    subscribe => File['nginx.conf'],
  }
}
