class graphite::aggregator (
  $line_receiver_interface = '0.0.0.0',
  $line_receiver_port = 2023,
  $pickle_receiver_interface = '0.0.0.0',
  $pickle_receiver_port = 2024,
  $log_listener_connections = true,
  $forward_all = true,
  $destinations = '127.0.0.1:2004',
  $replication_factor = 1,
  $max_queue_size = 10000,
  $use_flow_control = true,
  $max_datapoints_per_message = 500,
  $max_aggregation_intervals = 5,
  $write_back_frequency = 0,
  $use_whitelist = false,
  $carbon_metric_prefix = 'carbon',
  $carbon_metric_interval = 60,
) inherits graphite {
  include graphite::config

  $log_listener_connections_bool = str2bool($log_listener_connections)
  $forward_all_bool = str2bool($forward_all)
  $use_flow_control_bool = str2bool($use_flow_control)
  $use_whitelist_bool = str2bool($use_whitelist)

  concat::fragment {
    'carbon_aggregator':
      target  => $graphite::carbon_conf,
      order   => '03_aggregator',
      content => template('graphite/carbon_aggregator.conf.erb');
  }

  file {
    '/etc/init.d/carbon-aggregator':
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
      source => 'puppet:///modules/graphite/init/ubuntu-init.d-aggregator';
  }

  service {
    'carbon-aggregator':
      ensure  => running,
      enable  => true,
      require => Concat[$graphite::carbon_conf];
  }

  Concat::Fragment['carbon_aggregator'] ~> Service['carbon-aggregator']
  File['/etc/init.d/carbon-aggregator'] ~> Service['carbon-aggregator']
  Concat[$graphite::aggregation_rules_conf] ~> Service['carbon-aggregator']
}
