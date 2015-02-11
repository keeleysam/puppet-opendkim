# == Class: opendkim::install
#

class opendkim::install(
  $package                 = $::opendkim::package,
  $ensure_version          = $::opendkim::ensure_version,
){

  package { $package:
    ensure => $ensure_version,
    alias  => 'opendkim'
  }

}
