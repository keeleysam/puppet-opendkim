# == Class: opendkim
#
# Manage OpenDKIM.
# Main class to install, enable and setup default configuration.
# OS Support: Debian, Ubuntu
#
# === Parameters
#
# [*default_config*]
#   Set true to use the default configuration specified in opendkim::config.
#   Boolean, default is true.
#
# [*ensure_version*]
#   State of the opendkim package. Valid values are present (also called
#   installed), absent, purged, held, latest. Default is installed.
#
# === Examples
#
#  include 'opendkim'
#
#  opendkim::socket { 'listen on loopback on port 8891 - Ubuntu default':
#      interface => 'localhost';
#  }
#  opendkim::domain { 'example.com':
#      private_key => 'puppet:///modules/mymodule/example.com.key',
#  }
#
# === Authors
#
#  rjpearce https://github.com/rjpearce
#
class opendkim(
  $default_config  = $opendkim::params::default_config,
  $ensure_version  = $opendkim::params::ensure_version,
  $syslog          = $opendkim::params::syslog,
  $syslog_success  = $opendkim::params::syslog_success,
  $umask           = $opendkim::params::umask,
  $oversignheaders = $opendkim::params::oversignheaders,
  $internalhosts   = $opendkim::params::internalhosts,
  $package         = $opendkim::params::package,
  $service         = $opendkim::params::service,
  $user            = $opendkim::params::user,
) inherits ::opendkim::params {

  package { $opendkim::params::package:
    ensure => $ensure_version,
    alias  => 'opendkim'
  }
  service { $opendkim::params::service:
    enable  => true,
    require => Package['opendkim'];
  }
  file { '/etc/dkim':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0644';
  }
  if ($default_config) {
    include opendkim::config
  }
}
