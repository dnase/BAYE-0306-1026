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
}
