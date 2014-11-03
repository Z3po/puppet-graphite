require 'spec_helper'

describe 'graphite::aggregator' do
  let(:facts) {{
    :operatingsystem => 'Ubuntu',
    :concat_basedir => '/foo',
  }}

  context 'default parameters' do
    let(:params) {{}}

    it { should compile.with_all_deps }

    it { should contain_class('graphite::config') }
    it { should contain_class('graphite') }


    it { should contain_concat__fragment('carbon_aggregator').with(
      :target => '/etc/carbon/carbon.conf',
      :order => '03_aggregator',
    )}

    it { should contain_concat__fragment('carbon_aggregator').with_content(/\[aggregator\]/) }
    it { should contain_concat__fragment('carbon_aggregator').with_content(/LINE_RECEIVER_INTERFACE = 0\.0\.0\.0/) }
    it { should contain_concat__fragment('carbon_aggregator').with_content(/LINE_RECEIVER_PORT = 2023/) }
    it { should contain_concat__fragment('carbon_aggregator').with_content(/PICKLE_RECEIVER_INTERFACE = 0\.0\.0\.0/) }
    it { should contain_concat__fragment('carbon_aggregator').with_content(/PICKLE_RECEIVER_PORT = 2024/) }
    it { should contain_concat__fragment('carbon_aggregator').with_content(/LOG_LISTENER_CONNECTIONS = True/) }
    it { should contain_concat__fragment('carbon_aggregator').with_content(/FORWARD_ALL = True/) }
    it { should contain_concat__fragment('carbon_aggregator').with_content(/DESTINATIONS = 127\.0\.0\.1:2004/) }
    it { should contain_concat__fragment('carbon_aggregator').with_content(/REPLICATION_FACTOR = 1/) }
    it { should contain_concat__fragment('carbon_aggregator').with_content(/MAX_QUEUE_SIZE = 10000/) }
    it { should contain_concat__fragment('carbon_aggregator').with_content(/USE_FLOW_CONTROL = True/) }
    it { should contain_concat__fragment('carbon_aggregator').with_content(/MAX_DATAPOINTS_PER_MESSAGE = 500/) }
    it { should contain_concat__fragment('carbon_aggregator').with_content(/MAX_AGGREGATION_INTERVALS = 5/) }
    it { should contain_concat__fragment('carbon_aggregator').with_content(/WRITE_BACK_FREQUENCY = 0/) }
    it { should contain_concat__fragment('carbon_aggregator').with_content(/USE_WHITELIST = False/) }
    it { should contain_concat__fragment('carbon_aggregator').with_content(/CARBON_METRIC_PREFIX = carbon/) }
    it { should contain_concat__fragment('carbon_aggregator').with_content(/CARBON_METRIC_INTERVAL = 60/) }

    it { should contain_file('/etc/init.d/carbon-aggregator').with(
      :owner => 'root',
      :group => 'root',
      :mode  => '0755',
    )}

    it { should contain_service('carbon-aggregator').with(
      :enable => true,
      :ensure => 'running',
    )}

    it { should contain_concat__fragment('carbon_aggregator').that_notifies('Service[carbon-aggregator]') }
    it { should contain_file('/etc/init.d/carbon-aggregator').that_notifies('Service[carbon-aggregator]') }

  end

  context 'all parameters set' do
    let(:params) {{
      :line_receiver_interface => '10.51.50.42',
      :line_receiver_port => 4242,
      :pickle_receiver_interface => '10.51.50.43',
      :pickle_receiver_port => 4243,
      :replication_factor => 789,
      :max_queue_size => 790,
      :max_datapoints_per_message => 791,
      :max_aggregation_intervals => 792,
      :write_back_frequency => 793,
      :carbon_metric_prefix => 'aoeu',
      :carbon_metric_interval => 794,
    }}

    it { should contain_concat__fragment('carbon_aggregator').with_content(/LINE_RECEIVER_INTERFACE = 10\.51\.50\.42/) }
    it { should contain_concat__fragment('carbon_aggregator').with_content(/LINE_RECEIVER_PORT = 4242/) }
    it { should contain_concat__fragment('carbon_aggregator').with_content(/PICKLE_RECEIVER_INTERFACE = 10\.51\.50\.43/) }
    it { should contain_concat__fragment('carbon_aggregator').with_content(/PICKLE_RECEIVER_PORT = 4243/) }
    it { should contain_concat__fragment('carbon_aggregator').with_content(/REPLICATION_FACTOR = 789/) }
    it { should contain_concat__fragment('carbon_aggregator').with_content(/MAX_QUEUE_SIZE = 790/) }
    it { should contain_concat__fragment('carbon_aggregator').with_content(/MAX_DATAPOINTS_PER_MESSAGE = 791/) }
    it { should contain_concat__fragment('carbon_aggregator').with_content(/MAX_AGGREGATION_INTERVALS = 792/) }
    it { should contain_concat__fragment('carbon_aggregator').with_content(/WRITE_BACK_FREQUENCY = 793/) }
    it { should contain_concat__fragment('carbon_aggregator').with_content(/CARBON_METRIC_PREFIX = aoeu/) }
    it { should contain_concat__fragment('carbon_aggregator').with_content(/CARBON_METRIC_INTERVAL = 794/) }

  end

  context "boolean parameters true" do
    let(:params) {{
      :log_listener_connections => true,
      :forward_all => true,
      :use_flow_control => true,
      :use_whitelist => true,
    }}

    it { should contain_concat__fragment('carbon_aggregator').with_content(/LOG_LISTENER_CONNECTIONS = True/) }
    it { should contain_concat__fragment('carbon_aggregator').with_content(/FORWARD_ALL = True/) }
    it { should contain_concat__fragment('carbon_aggregator').with_content(/USE_FLOW_CONTROL = True/) }
    it { should contain_concat__fragment('carbon_aggregator').with_content(/USE_WHITELIST = True/) }
  end
  
  context "boolean parameters false" do
    let(:params) {{
      :log_listener_connections => false,
      :forward_all => false,
      :use_flow_control => false,
      :use_whitelist => false,
    }}

    it { should contain_concat__fragment('carbon_aggregator').with_content(/LOG_LISTENER_CONNECTIONS = False/) }
    it { should contain_concat__fragment('carbon_aggregator').with_content(/FORWARD_ALL = False/) }
    it { should contain_concat__fragment('carbon_aggregator').with_content(/USE_FLOW_CONTROL = False/) }
    it { should contain_concat__fragment('carbon_aggregator').with_content(/USE_WHITELIST = False/) }
  end

  context "arrayable parameters single value" do
    let(:params) {{
      :destinations => '127.0.0.1:6789',
    }}

    it { should contain_concat__fragment('carbon_aggregator').with_content(/DESTINATIONS = 127\.0\.0\.1:6789/) }
  end

  context "arrayable parameters arrays" do
    let(:params) {{
      :destinations => ['127.0.0.1:6789','127.0.0.1:6790'],
    }}
    it { should contain_concat__fragment('carbon_aggregator').with_content(/DESTINATIONS = 127\.0\.0\.1:6789,127\.0\.0\.1:6790/) }
  end

end
