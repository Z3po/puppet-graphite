define graphite::blacklist (
  $pattern,
) {
  include graphite
  concat::fragment { "carbon_blacklist_${name}":
    target  => $graphite::blacklist_conf,
    order   => $name,
    content => inline_template("<%= Array(@pattern).join(\"\n\") %>\n"),
  }
}
