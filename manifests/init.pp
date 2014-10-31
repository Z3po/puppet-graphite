# == Class: graphite
#
# installs and configures graphite
#
# === Authors
#
# Jeremy Kitchen <jeremy@nationbuilder.com>
#
# === Copyright
#
# Copyright 2014 3dna Corp
#
class graphite (
  $package_name                       = $graphite::params::package_name,
  $cache_init_template                = $graphite::params::cache_init_template,
  $conf_dir                           = $graphite::params::conf_dir,
  $carbon_conf                        = "${conf_dir}/carbon.conf",
  $storage_schemas_conf               = "${conf_dir}/storage_schemas.conf",
  $storage_aggregation_conf           = "${conf_dir}/storage_aggregation.conf",
  $storage_dir                        = $graphite::params::storage_dir,
  $log_dir                            = $graphite::params::log_dir,
  $pid_dir                            = $graphite::params::pid_dir,
  $local_data_dir                     = $graphite::params::local_data_dir,
  $user                               = $graphite::params::user,
  $group                              = $graphite::params::group,
  $enable_logrotation                 = false,
  $max_cache_size                     = 'inf',
  $max_updates_per_second             = 500,
  $max_updates_per_second_on_shutdown = undef,
  $max_creates_per_minute             = 50,
  $line_receiver_interface            = '0.0.0.0',
  $enable_udp_listener                = false,
  $udp_receiver_interface             = '0.0.0.0',
  $pickle_receiver_interface          = '0.0.0.0',
  $log_listener_connections           = true,
  $use_insecure_unpickler             = false,
  $cache_query_interface              = '0.0.0.0',
  $use_flow_control                   = true,
  $log_updates                        = false,
  $log_cache_hits                     = false,
  $log_cache_queue_sorts              = true,
  $cache_write_strategy               = 'sorted',
  $whisper_autoflush                  = false,
  $whisper_sparse_create              = false,
  $whisper_fallocate_create           = true,
  $whisper_lock_writes                = false,
  $use_whitelist                      = false,
  $carbon_metric_prefix               = 'carbon',
  $carbon_metric_interval             = 60,
  $enable_amqp                        = false,
  $amqp_verbose                       = false,
  $amqp_host                          = 'localhost',
  $amqp_port                          = 5672,
  $amqp_vhost                         = '/',
  $amqp_user                          = 'guest',
  $amqp_password                      = 'guest',
  $amqp_exchange                      = 'graphite',
  $amqp_metric_name_in_body           = false,
  $bind_patterns                      = undef,
  $enable_manhole                     = false,
  $manhole_interface                  = '127.0.0.1',
  $manhole_port                       = 7222,
  $manhole_user                       = 'admin',
  $manhole_public_key                 = undef,
) inherits graphite::params {
  # these have to be up here because order doesn't matter with puppet
  # except when it does.
  # :(
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

  Class['graphite::install'] -> Class['graphite::config']

  include graphite::install
  include graphite::config

}
