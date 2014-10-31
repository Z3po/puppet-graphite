define graphite::cache::service (
  $enabled = true,
  $service_ensure = running,
) {
  include graphite

  file { "${graphite::init_path}/carbon-cache-${name}":
    content => template($graphite::carbon_init_template),
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    notify  => Service["carbon-cache-${name}"],
  }

  service { "carbon-cache-${name}":
    enabled   => $enabled,
    ensure    => $service_ensure,
  }
}
