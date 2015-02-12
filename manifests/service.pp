# == Class: opendkim::service

class opendkim::service(
  $service                 = $::opendkim::service,
  $package                 = $::opendkim::package,
){

  service { $service :
    enable  => true,
    ensure  => running,
    require => Package[$package];
  }

}
