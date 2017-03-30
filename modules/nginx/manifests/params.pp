class nginx::params {
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
  $highperf = true
}
