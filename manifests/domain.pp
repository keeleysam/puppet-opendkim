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
#  opendkim::domain { 'example.com':
#      private_key => 'puppet:///modules/mymodule/example.com.key',
#  }
#
#   See opendkim init for complete example.
#
# === Authors
#
#  rjpearce https://github.com/rjpearce
#

define opendkim::domain(
  $private_key,
  $domain       = $name,
  $selector     = 'mail',
  $key_folder   = '/etc/dkim',
  $signing_key  = $name,
  $user         = $::opendkim::user,
  $service      = $::opendkim::service,
  $keytable     = $::opendkim::keytable,
  $signingtable = $::opendkim::signingtable,

) {
  $key_file = "${key_folder}/${selector}-${domain}.key"

  file { $key_file:
    owner  => $user,
    group  => 'root',
    mode   => '0600',
    source => $private_key,
    notify => Service[$service],
  }

  concat { $signingtable : }
  concat { $keytable : }

  concat::fragment{ "signingtable_${name}":
    target  => $signingtable,
    content => "${signing_key} ${selector}._domainkey.${domain}\n",
    order   => 10,
    require => File[$key_file],
    notify  => Service[$service],

  }
  concat::fragment{ "keytable_${name}":
    target  => $keytable,
    content => "${selector}._domainkey.${domain} ${domain}:${selector}:${key_file}\n",
    order   => 10,
    require => File[$key_file],
    notify  => Service[$service],
  }
}

