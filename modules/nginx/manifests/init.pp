class nginx (
  String $package = $nginx::params::package,
  String $owner = $nginx::params::owner,
  String $group = $nginx::params::group,
  String $docroot = $nginx::params::docroot,
  String $confdir = $nginx::params::confdir,
  String $logdir = $nginx::params::logdir,
  String $user = $nginx::params::user,
  Boolean $highperf = $nginx::params::highperf,
) inherits nginx::params {
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
    ensure     => file,
    path       => "${confdir}/nginx.conf",
    content    => epp('nginx/nginx.conf.epp', {
      docroot  => $docroot,
      logdir   => $logdir,
      confdir  => $confdir,
      user     => $user,
      highperf => $highperf,
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
