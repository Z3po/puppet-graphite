# == Define: graphite::storage_aggregation
#
# configures a storage-aggregation.conf entry for graphite
#
# === Authors
#
# Jeremy Kitchen <jeremy@nationbuilder.com>
#
# === Copyright
#
# Copyright 2014 3dna Corp
#
define graphite::storage_aggregation (
  $pattern,
  $xFilesFactor = undef,
  $aggregationMethod = undef,
  $order = 100,
) {
  include graphite::config

  concat::fragment { "storage_aggregation_${name}":
    target  => $graphite::config::storage_aggregation_conf,
    content => template('graphite/storage_aggregation.conf-part.erb'),
    order   => $order,
  }
}
