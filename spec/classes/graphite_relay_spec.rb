require 'spec_helper'

describe 'graphite::relay' do
  let(:default_facts) {{
    :concat_basedir => '/foo',
  }}

  context 'default parameters' do
    let(:facts) {
      {
        :operatingsystem => 'Ubuntu',
      }.merge default_facts
    }

    it { should compile.with_all_deps }

    it { should contain_class('graphite::config') }
    it { should contain_class('graphite') }

    it { should contain_concat__fragment('carbon_relay').with(
      :target => '/etc/carbon/carbon.conf',
      :order => '02_relay',
    ) }

    it { should contain_concat__fragment('carbon_relay').with_content(/\[relay\]/) }
    it { should contain_concat__fragment('carbon_relay').with_content(/LINE_RECEIVER_INTERFACE = 0\.0\.0\.0/) }
    it { should contain_concat__fragment('carbon_relay').with_content(/LINE_RECEIVER_PORT = 2013/) }
    it { should contain_concat__fragment('carbon_relay').with_content(/PICKLE_RECEIVER_INTERFACE = 0\.0\.0\.0/) }
    it { should contain_concat__fragment('carbon_relay').with_content(/PICKLE_RECEIVER_PORT = 2014/) }
    it { should contain_concat__fragment('carbon_relay').with_content(/LOG_LISTENER_CONNECTIONS = True/) }
    it { should contain_concat__fragment('carbon_relay').with_content(/RELAY_METHOD = rules/) }
    it { should contain_concat__fragment('carbon_relay').with_content(/REPLICATION_FACTOR = 1/) }
    it { should contain_concat__fragment('carbon_relay').with_content(/DESTINATIONS = 127\.0\.0\.1:2004/) }
    it { should contain_concat__fragment('carbon_relay').with_content(/MAX_DATAPOINTS_PER_MESSAGE = 500/) }
    it { should contain_concat__fragment('carbon_relay').with_content(/MAX_QUEUE_SIZE = 10000/) }
    it { should contain_concat__fragment('carbon_relay').with_content(/USE_FLOW_CONTROL = True/) }
    it { should contain_concat__fragment('carbon_relay').with_content(/USE_WHITELIST = False/) }
    it { should contain_concat__fragment('carbon_relay').with_content(/CARBON_METRIC_PREFIX = carbon/) }
    it { should contain_concat__fragment('carbon_relay').with_content(/CARBON_METRIC_INTERVAL = 60/) }

    it { should contain_file('/etc/init.d/carbon-relay').with(
      :owner => 'root',
      :group => 'root',
      :mode => '0755',
    )}

    it { should contain_service('carbon-relay').with(
      :ensure => 'running',
      :enable => true,
    )}

    it { should contain_concat__fragment('carbon_relay').that_notifies('Service[carbon-relay]') }
    it { should contain_file('/etc/init.d/carbon-relay').that_notifies('Service[carbon-relay]') }
    it { should contain_concat('/etc/carbon/relay-rules.conf').that_notifies('Service[carbon-relay]') }

  end
  
  context 'all parameters set' do
    let(:facts) {
      {
        :operatingsystem => 'Ubuntu',
      }.merge default_facts
    }

    let(:params) {{
      :line_receiver_interface    => '10.42.0.42',
      :line_receiver_port         => 6789,
      :pickle_receiver_interface  => '10.42.0.43',
      :pickle_receiver_port       => 6790,
      :relay_method               => 'shotgun',
      :replication_factor         => 42,
      :max_datapoints_per_message => 404,
      :max_queue_size             => 405,
      :carbon_metric_prefix       => 'foo',
      :carbon_metric_interval     => 406,
    }}

    it { should contain_concat__fragment('carbon_relay').with(
      :target => '/etc/carbon/carbon.conf',
      :order => '02_relay',
    )}

    it { should contain_concat__fragment('carbon_relay').with_content(/LINE_RECEIVER_INTERFACE = 10\.42\.0\.42/) }
    it { should contain_concat__fragment('carbon_relay').with_content(/LINE_RECEIVER_PORT = 6789/) }
    it { should contain_concat__fragment('carbon_relay').with_content(/PICKLE_RECEIVER_INTERFACE = 10\.42\.0\.43/) }
    it { should contain_concat__fragment('carbon_relay').with_content(/PICKLE_RECEIVER_PORT = 6790/) }
    it { should contain_concat__fragment('carbon_relay').with_content(/RELAY_METHOD = shotgun/) }
    it { should contain_concat__fragment('carbon_relay').with_content(/REPLICATION_FACTOR = 42/) }
    it { should contain_concat__fragment('carbon_relay').with_content(/MAX_DATAPOINTS_PER_MESSAGE = 404/) }
    it { should contain_concat__fragment('carbon_relay').with_content(/MAX_QUEUE_SIZE = 405/) }
    it { should contain_concat__fragment('carbon_relay').with_content(/CARBON_METRIC_PREFIX = foo/) }
    it { should contain_concat__fragment('carbon_relay').with_content(/CARBON_METRIC_INTERVAL = 406/) }
  end

  context "boolean paramaters set to true" do
    let(:facts) {
      {
        :operatingsystem => 'Ubuntu',
      }.merge default_facts
    }

    let(:params) {{
      :log_listener_connections => true,
      :use_flow_control => true,
      :use_whitelist => true,
    }}

    it { should contain_concat__fragment('carbon_relay').with_content(/LOG_LISTENER_CONNECTIONS = True/) }
    it { should contain_concat__fragment('carbon_relay').with_content(/USE_FLOW_CONTROL = True/) }
    it { should contain_concat__fragment('carbon_relay').with_content(/USE_WHITELIST = True/) }
  end

  context "boolean parameters set to false" do
    let(:facts) {
      {
        :operatingsystem => 'Ubuntu',
      }.merge default_facts
    }

    let(:params) {{
      :log_listener_connections => false,
      :use_flow_control => false,
      :use_whitelist => false,
    }}

    it { should contain_concat__fragment('carbon_relay').with_content(/LOG_LISTENER_CONNECTIONS = False/) }
    it { should contain_concat__fragment('carbon_relay').with_content(/USE_FLOW_CONTROL = False/) }
    it { should contain_concat__fragment('carbon_relay').with_content(/USE_WHITELIST = False/) }
  end

  context "arrayable parameters set to single value" do
    let(:facts) {
      {
        :operatingsystem => 'Ubuntu',
      }.merge default_facts
    }

    let(:params) {{
      :destinations => '127.0.0.1:1234',
    }}

    it { should contain_concat__fragment('carbon_relay').with_content(/DESTINATIONS = 127\.0\.0\.1:1234/) }
  end
  
  context "arrayable parameters set to array value" do
    let(:facts) {
      {
        :operatingsystem => 'Ubuntu',
      }.merge default_facts
    }

    let(:params) {{
      :destinations => ['127.0.0.1:1235','127.0.0.1:1236'],
    }}

    it { should contain_concat__fragment('carbon_relay').with_content(/DESTINATIONS = 127\.0\.0\.1:1235,127\.0\.0\.1:1236/) }
  end

end
