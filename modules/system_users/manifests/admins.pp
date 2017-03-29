class system_users::admins {
  user { 'admin':
    ensure => present,
    gid    => 'staff',
    shell  => '/bin/csh',
  }
  group { 'staff':
    ensure => present,
  }
}
