# == Class: opendkim::service

class opendkim::service(
  $service                 = $::opendkim::service,
){

  service { $service :
    enable  => true,
    require => Package['opendkim'];
  }

}
