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
    owner => $graphite::user,
    group => $graphite::group,
    mode  => '0600',
    warn  => true,
  }

  concat { [$graphite::carbon_conf, $graphite::storage_schemas_conf, $graphite::storage_aggregation_conf]: }
}
