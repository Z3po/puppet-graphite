define graphite::whitelist (
  $pattern,
) {
  include graphite
  concat::fragment { "carbon_whitelist_${name}":
    target  => $graphite::whitelist_conf,
    order   => $name,
    content => inline_template("<%= Array(@pattern).join(\"\n\") %>\n"),
  }
}
