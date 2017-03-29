class hosts {
  host { 'testing.puppetlabs.vm':
    ensure       => 'present',
    host_aliases => ['testing'],
    ip           => '127.0.0.1',
  }
}
