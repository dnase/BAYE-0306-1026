include ::nginx
nginx::vhost { 'mytest.puppetlabs.vm':
  port => '8080',
}
nginx::vhost { 'drew2.puppetlabs.vm':
  port => '8081',
}
