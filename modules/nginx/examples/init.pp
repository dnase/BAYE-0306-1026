file { '/var/www':
  ensure => directory,
}
class { 'nginx':
  root     => '/var/www/html',
  highperf => false
}
