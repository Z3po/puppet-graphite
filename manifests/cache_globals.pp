class graphite::cache_globals inherits graphite {
  concat::fragment {
    'carbon_cache_globals':
      target  => $graphite::carbon_conf,
      content => template('graphite/cache_global.conf.erb'),
      order   => '10_cache_globals';
  }
}
