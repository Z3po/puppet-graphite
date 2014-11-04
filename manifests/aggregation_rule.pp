define graphite::aggregation_rule (
  $output_template,
  $method,
  $input_pattern,
  $frequency = 60,
) {
  include graphite

  concat::fragment { "aggregation_rule_${name}":
    target  => $graphite::aggregation_rules_conf,
    order   => $name,
    content => "${output_template} (${frequency}) ${method} ${input_pattern}",
  }
}
