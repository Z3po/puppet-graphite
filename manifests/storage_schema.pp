# == Define: graphite::storage_schema
#
# configures a storage-schema.conf entry for graphite
#
# === Authors
#
# Jeremy Kitchen <jeremy@nationbuilder.com>
#
# === Copyright
#
# Copyright 2014 3dna Corp
#
define graphite::storage_schema (
  $pattern,
  $retentions,
  $order = 100,
) {
  include graphite::config

  concat::fragment { "storage_schema_${name}":
    target  => $graphite::config::storage_schemas_conf,
    content => inline_template("[<%= @name %>]\npattern = <%= @pattern %>\nretentions = <%= Array(@retentions).join(', ') %>\n\n"),
    order   => $order,
  }
}
