# == Class: opendkim::config
#
# Manage OpenDKIM configuration
#
# === Parameters
#
# [*syslog*]
#   Inherited from params class.
#
# [*umask*]
#   Inherited from params class.
#
# [*oversignheaders*]
#   Inherited from params class.
#
# === Examples
#
#   See opendkim init for complete example.
#
# === Authors
#
#  rjpearce https://github.com/rjpearce
#


class opendkim::config(
  $syslog                  = $::opendkim::syslog,
  $syslog_success          = $::opendkim::syslog_success,
  $umask                   = $::opendkim::umask,
  $oversignheaders         = $::opendkim::oversignheaders,
  $internalhosts           = $::opendkim::internalhosts,
  $service                 = $::opendkim::service,
){

  file { '/etc/dkim':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0644';
  }

  file { '/etc/opendkim.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('opendkim/opendkim.conf.erb'),
    notify  => Service[$service],
  }

  file { '/etc/default/opendkim':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('opendkim/opendkim_default.erb'),
    notify  => Service[$service],
  }

}
