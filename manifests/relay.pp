class graphite::relay (
  $line_receiver_interface = '0.0.0.0',
  $line_receiver_port = 2013,
  $pickle_receiver_interface = '0.0.0.0',
  $pickle_receiver_port = 2014,
  $log_listener_connections = true,
  $relay_method = 'rules',
  $replication_factor = 1,
  $destinations = '127.0.0.1:2004',
  $max_datapoints_per_message = 500,
  $max_queue_size = 10000,
  $use_flow_control = true,
  $use_whitelist = false,
  $carbon_metric_prefix = 'carbon',
  $carbon_metric_interval = 60,
) inherits graphite {
  include graphite::config

  $log_listener_connections_bool = str2bool($log_listener_connections)
  $use_flow_control_bool = str2bool($use_flow_control)
  $use_whitelist_bool = str2bool($use_whitelist)
  concat::fragment {
    'carbon_relay':
      target  => $graphite::carbon_conf,
      order   => '02_relay',
      content => template('graphite/carbon_relay.conf.erb'),
  }

  file { '/etc/init.d/carbon-relay':
    source => 'puppet:///modules/graphite/init/ubuntu-init.d-relay',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  service {  'carbon-relay':
    ensure => running,
    enable => true,
  }

  Concat::Fragment['carbon_relay'] ~> Service['carbon-relay']
  File['/etc/init.d/carbon-relay'] ~> Service['carbon-relay']
}
