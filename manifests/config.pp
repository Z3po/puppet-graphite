# == Class: graphite::config
#
# sets up various carbon config files
#
# === Authors
#
# Jeremy Kitchen <jeremy@nationbuilder.com>
#
# === Copyright
#
# Copyright 2014 3dna Corp
#
class graphite::config inherits graphite {
  contain graphite::cache_globals

  Concat {
    owner => $user,
    group => $group,
    mode  => '0600',
    warn  => true,
  }

  concat { [$carbon_conf, $storage_schemas_conf, $storage_aggregation_conf]: }
}
