define nginx::vhost (
  $port = '80',
  $server_name = $title,
  $docroot = "${nginx::docroot}/vhosts/${title}",
) {
  File {
    owner => $nginx::owner,
    group => $nginx::group,
    mode  => '0664',
  }
  host { $title:
    ip => $::ipaddress,
  }
  file { $docroot:
    ensure => directory,
  }
  file { "vhost-${title}":
    ensure        => file,
    path          => "${nginx::confdir}/conf.d/vhost-${title}.conf",
    content       => epp('nginx/vhost.conf.epp', {
      port        => $port,
      docroot     => $docroot,
      title       => $title,
      server_name => $server_name,
    }),
    require => File[$docroot],
    notify  => Service['nginx'],
  }
  file { "${docroot}/index.html":
    ensure  => file,
    content => epp('nginx/index.html.epp',{server_name => $server_name}),
  }
}
