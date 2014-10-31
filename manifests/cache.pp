define graphite::cache (
  $line_receiver_port                 = 2003,
  $udp_receiver_port                  = 2003,
  $pickle_receiver_port               = 2004,
  $cache_query_port                   = 7002,
  $conf_dir                           = undef,
  $storage_dir                        = undef,
  $log_dir                            = undef,
  $pid_dir                            = undef,
  $local_data_dir                     = undef,
  $user                               = undef,
  $enable_logrotation                 = undef,
  $max_updates_per_second             = undef,
  $max_updates_per_second_on_shutdown = undef,
  $max_creates_per_minute             = undef,
  $line_receiver_interface            = undef,
  $enable_udp_listener                = undef,
  $udp_receiver_interface             = undef,
  $pickle_receiver_interface          = undef,
  $log_listener_connections           = undef,
  $use_insecure_unpickler             = undef,
  $cache_query_interface              = undef,
  $use_flow_control                   = undef,
  $log_updates                        = undef,
  $log_cache_hits                     = undef,
  $log_cache_queue_sorts              = undef,
  $cache_write_strategy               = undef,
  $whisper_autoflush                  = undef,
  $whisper_sparse_create              = undef,
  $whisper_fallocate_create           = undef,
  $whisper_lock_writes                = undef,
  $use_whitelist                      = undef,
  $carbon_metric_prefix               = undef,
  $carbon_metric_interval             = undef,
  $enable_amqp                        = undef,
  $amqp_verbose                       = undef,
  $amqp_host                          = undef,
  $amqp_port                          = undef,
  $amqp_vhost                         = undef,
  $amqp_user                          = undef,
  $amqp_password                      = undef,
  $amqp_exchange                      = undef,
  $amqp_metric_name_in_body           = undef,
  $bind_patterns                      = undef,
  $enable_manhole                     = undef,
  $manhole_interface                  = undef,
  $manhole_port                       = undef,
  $manhole_user                       = undef,
  $manhole_public_key                 = undef,
) {
  include graphite
  include graphite::cache_globals

  validate_re($name, '^[\w\d_]+$')
  $enable_logrotation_bool = str2bool($enable_logrotation)
  $enable_udp_listener_bool = str2bool($enable_udp_listener)
  $log_listener_connections_bool = str2bool($log_listener_connections)
  $use_insecure_unpickler_bool = str2bool($use_insecure_unpickler)
  $use_flow_control_bool = str2bool($use_flow_control)
  $log_updates_bool = str2bool($log_updates)
  $log_cache_hits_bool = str2bool($log_cache_hits)
  $log_cache_queue_sorts_bool = str2bool($log_cache_queue_sorts)
  $whisper_autoflush_bool = str2bool($whisper_autoflush)
  $whisper_sparse_create_bool = str2bool($whisper_sparse_create)
  $whisper_fallocate_create_bool = str2bool($whisper_fallocate_create)
  $whisper_lock_writes_bool = str2bool($whisper_lock_writes)
  $use_whitelist_bool = str2bool($use_whitelist)
  $enable_amqp_bool = str2bool($enable_amqp)
  $amqp_verbose_bool = str2bool($amqp_verbose)
  $amqp_metric_name_in_body_bool = str2bool($amqp_metric_name_in_body)
  $enable_manhole_bool = str2bool($enable_manhole)

  concat::fragment { "carbon_cache_${name}":
    target  => $graphite::carbon_conf,
    content => template('graphite/cache.conf.erb'),
    order   => "20_cache_${name}",
  }

  file { "/etc/init.d/carbon-cache-${name}":
    content => template($graphite::cache_init_template),
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }

  service { "carbon-cache-${name}":
    ensure => running,
    enable => true,
  }

  Class['graphite::cache_globals'] ~> Service["carbon-cache-${name}"]
  Concat::Fragment["carbon_cache_${name}"] ~> Service["carbon-cache-${name}"]
  File["/etc/init.d/carbon-cache-${name}"] ~> Service["carbon-cache-${name}"]

}
