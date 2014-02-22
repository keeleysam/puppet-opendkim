define opendkim::domain(
  $private_key,
  $domain=$name,
  $selector='mail',
  $key_folder='/etc/dkim'
) {

  file {
    "${key_folder}/${domain}.key":
      owner  => 'root',
      group  => 'root',
      mode   => 0640,
      source => $private_key;
  }
  concat::fragment{ $name:
    target  => '/etc/opendkim.conf',
    content => "Domain ${domain}\nKeyFile ${key_folder}/${domain}.key\nSelector ${selector}\n\n",
    order   => 10,
    require => File["$key_folder/$domain.key"],
    notify  => Service[$opendkim::params::service];
  }

}
