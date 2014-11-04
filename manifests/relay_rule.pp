define graphite::relay_rule (
  $pattern,
  $servers,
  $order = 100,
) {
  include graphite

  concat::fragment { "carbon_relay_rule_${name}":
    target  => $graphite::relay_rules_conf,
    order   => $order,
    content => inline_template("[<%= @name %>]\npattern = <%= @pattern %>\nservers = <%= Array(@servers).join(', ') %>\n\n"),
  }
}
