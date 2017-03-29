class system_users {
  user { 'fundamentals':
    ensure     => present,
    home       => '/home/fundamentals',
    managehome => true,
  }
}
