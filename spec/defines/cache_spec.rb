require 'spec_helper'

describe 'graphite::cache', :type => 'define' do
  let(:facts) {{ 
    :operatingsystem => 'Ubuntu',
    :concat_basedir => '/foo',
  }}

  let(:title) { 'a' }

  context "all parameters exist" do
    let(:params) {{
      :line_receiver_port => 4567,
      :udp_receiver_port => 4568,
      :pickle_receiver_port => 4569,
      :cache_query_port => 4570,
      :conf_dir => '/foo/bar',
      :storage_dir => '/foo/lib/graphite',
      :log_dir => '/foo/log/graphite',
      :pid_dir => '/foo/pid/graphite',
      :local_data_dir => '/foo/data/graphite',
      :user => 'foo',
      :max_updates_per_second => '1234',
      :max_updates_per_second_on_shutdown => '1235',
      :max_creates_per_minute => '1236',
      :line_receiver_interface => '10.0.0.1',
      :udp_receiver_interface => '10.0.0.2',
      :pickle_receiver_interface => '10.0.0.3',
      :cache_query_interface => '10.0.0.4',
      :carbon_metric_prefix => 'aoeuhtns',
      :carbon_metric_interval => '9876',
      :amqp_host => 'amqp.foohost',
      :amqp_port => '4571',
      :amqp_vhost => 'batamqp',
      :amqp_user => 'fooamqp',
      :amqp_password => 'baramqp',
      :amqp_exchange => 'bazamqp',
      :manhole_interface => '10.0.0.5',
      :manhole_port => '4572',
      :manhole_user => 'foomanhole',
      :manhole_public_key => 'HTNSAOEU',
    }}

    it { should contain_concat__fragment('carbon_cache_a').with(
        'order' => '20_cache_a',
        'target' => '/etc/carbon/carbon.conf',
      )
    }

    it { should contain_concat__fragment('carbon_cache_a').with_content(/\[cache:a\]/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/LINE_RECEIVER_PORT = 4567/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/UDP_RECEIVER_PORT = 4568/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/PICKLE_RECEIVER_PORT = 4569/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/CACHE_QUERY_PORT = 4570/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(%r{CONF_DIR = /foo/bar}) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(%r{STORAGE_DIR = /foo/lib/graphite}) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(%r{LOG_DIR = /foo/log/graphite}) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(%r{PID_DIR = /foo/pid/graphite}) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(%r{LOCAL_DATA_DIR = /foo/data/graphite}) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/USER = foo/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/MAX_UPDATES_PER_SECOND = 1234/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/MAX_UPDATES_PER_SECOND_ON_SHUTDOWN = 1235/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/MAX_CREATES_PER_MINUTE = 1236/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/LINE_RECEIVER_INTERFACE = 10\.0\.0\.1/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/UDP_RECEIVER_INTERFACE = 10\.0\.0\.2/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/PICKLE_RECEIVER_INTERFACE = 10\.0\.0\.3/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/CACHE_QUERY_INTERFACE = 10\.0\.0\.4/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/CARBON_METRIC_PREFIX = aoeuhtns/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/CARBON_METRIC_INTERVAL = 9876/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/AMQP_HOST = amqp\.foohost/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/AMQP_PORT = 4571/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/AMQP_VHOST = batamqp/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/AMQP_USER = fooamqp/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/AMQP_PASSWORD = baramqp/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/AMQP_EXCHANGE = bazamqp/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/MANHOLE_INTERFACE = 10\.0\.0\.5/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/MANHOLE_PORT = 4572/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/MANHOLE_USER = foomanhole/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/MANHOLE_PUBLIC_KEY = HTNSAOEU/) }
  end

  context "with no parameters specified" do
    let(:params) { {} }
    it { should contain_concat__fragment('carbon_cache_a').with(
        'order' => '20_cache_a',
        'target' => '/etc/carbon/carbon.conf',
      )
    }

    it { should contain_concat__fragment('carbon_cache_a').with_content(/\[cache:a\]/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/LINE_RECEIVER_PORT = \d+/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/UDP_RECEIVER_PORT = \d+/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/PICKLE_RECEIVER_PORT = \d+/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/CACHE_QUERY_PORT = \d+/) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(%r{CONF_DIR = }) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(%r{STORAGE_DIR = }) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(%r{LOG_DIR = }) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(%r{PID_DIR = }) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(%r{LOCAL_DATA_DIR = }) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/USER = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/MAX_UPDATES_PER_SECOND = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/MAX_UPDATES_PER_SECOND_ON_SHUTDOWN = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/MAX_CREATES_PER_MINUTE = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/LINE_RECEIVER_INTERFACE = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/UDP_RECEIVER_INTERFACE = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/PICKLE_RECEIVER_INTERFACE = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/CACHE_QUERY_INTERFACE = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/CARBON_METRIC_PREFIX = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/CARBON_METRIC_INTERVAL = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/AMQP_HOST = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/AMQP_PORT = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/AMQP_VHOST = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/AMQP_USER = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/AMQP_PASSWORD = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/AMQP_EXCHANGE = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/MANHOLE_INTERFACE = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/MANHOLE_PORT = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/MANHOLE_USER = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/MANHOLE_PUBLIC_KEY = /) }
    it { should contain_concat__fragment('carbon_cache_a').that_notifies('Service[carbon-cache-a]') }

    it { should contain_file('/etc/init.d/carbon-cache-a').with(
      :owner => 'root',
      :group => 'root',
      :mode  => '0755',
    )}

    it { should contain_file('/etc/init.d/carbon-cache-a').with_content(/--instance=a/) }
    it { should contain_file('/etc/init.d/carbon-cache-a').with_content(%r{\nNAME=carbon-cache-a}) }
    it { should contain_file('/etc/init.d/carbon-cache-a').that_notifies('Service[carbon-cache-a]') }
    it { should contain_class('graphite::cache_globals').that_notifies('Service[carbon-cache-a]') }
    it { should contain_concat('/etc/carbon/carbon.conf').that_comes_before('Service[carbon-cache-a]') }

    it { should contain_service('carbon-cache-a').with(
      :enable => true,
      :ensure  => 'running',
    )}

  end

  context "tri-bool parameters unspecified" do
    let(:params) { {} }

    it { should contain_concat__fragment('carbon_cache_a').with(
        'order' => '20_cache_a',
        'target' => '/etc/carbon/carbon.conf',
      )
    }

    it { should contain_concat__fragment('carbon_cache_a').without_content(/ENABLE_LOGROTATION = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/ENABLE_UDP_LISTENER = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/LOG_LISTENER_CONNECTIONS = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/USE_INSECURE_UNPICKLER = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/USE_FLOW_CONTROL = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/LOG_UPDATES = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/LOG_CACHE_HITS = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/LOG_CACHE_QUEUE_SORTS = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/WHISPER_AUTOFLUSH = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/WHISPER_SPARSE_CREATE = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/WHISPER_FALLOCATE_CREATE = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/WHISPER_LOCK_WRITES = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/USE_WHITELIST = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/ENABLE_AMQP = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/AMQP_VERBOSE = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/AMQP_METRIC_NAME_IN_BODY = /) }
    it { should contain_concat__fragment('carbon_cache_a').without_content(/ENABLE_MANHOLE = /) }
  end

  context "tri-bool parameters specified true" do
    let(:params) {{
      :enable_logrotation => true,
      :enable_udp_listener => true,
      :log_listener_connections => true,
      :use_insecure_unpickler => true,
      :use_flow_control => true,
      :log_updates => true,
      :log_cache_hits => true,
      :log_cache_queue_sorts => true,
      :whisper_autoflush => true,
      :whisper_sparse_create => true,
      :whisper_fallocate_create => true,
      :whisper_lock_writes => true,
      :use_whitelist => true,
      :enable_amqp => true,
      :amqp_verbose => true,
      :amqp_metric_name_in_body => true,
      :enable_manhole => true,
    }}

    it { should contain_concat__fragment('carbon_cache_a').with(
        'order' => '20_cache_a',
        'target' => '/etc/carbon/carbon.conf',
      )
    }

    it { should contain_concat__fragment('carbon_cache_a').with_content(/ENABLE_LOGROTATION = True/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/ENABLE_UDP_LISTENER = True/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/LOG_LISTENER_CONNECTIONS = True/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/USE_INSECURE_UNPICKLER = True/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/USE_FLOW_CONTROL = True/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/LOG_UPDATES = True/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/LOG_CACHE_HITS = True/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/LOG_CACHE_QUEUE_SORTS = True/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/WHISPER_AUTOFLUSH = True/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/WHISPER_SPARSE_CREATE = True/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/WHISPER_FALLOCATE_CREATE = True/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/WHISPER_LOCK_WRITES = True/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/USE_WHITELIST = True/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/ENABLE_AMQP = True/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/AMQP_VERBOSE = True/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/AMQP_METRIC_NAME_IN_BODY = True/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/ENABLE_MANHOLE = True/) }
  end

  context "tri-bool parameters specified false" do
    let(:params) {{
      :enable_logrotation => false,
      :enable_udp_listener => false,
      :log_listener_connections => false,
      :use_insecure_unpickler => false,
      :use_flow_control => false,
      :log_updates => false,
      :log_cache_hits => false,
      :log_cache_queue_sorts => false,
      :whisper_autoflush => false,
      :whisper_sparse_create => false,
      :whisper_fallocate_create => false,
      :whisper_lock_writes => false,
      :use_whitelist => false,
      :enable_amqp => false,
      :amqp_verbose => false,
      :amqp_metric_name_in_body => false,
      :enable_manhole => false,
    }}

    it { should contain_concat__fragment('carbon_cache_a').with(
        'order' => '20_cache_a',
        'target' => '/etc/carbon/carbon.conf',
      )
    }

    it { should contain_concat__fragment('carbon_cache_a').with_content(/ENABLE_LOGROTATION = False/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/ENABLE_UDP_LISTENER = False/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/LOG_LISTENER_CONNECTIONS = False/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/USE_INSECURE_UNPICKLER = False/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/USE_FLOW_CONTROL = False/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/LOG_UPDATES = False/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/LOG_CACHE_HITS = False/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/LOG_CACHE_QUEUE_SORTS = False/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/WHISPER_AUTOFLUSH = False/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/WHISPER_SPARSE_CREATE = False/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/WHISPER_FALLOCATE_CREATE = False/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/WHISPER_LOCK_WRITES = False/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/USE_WHITELIST = False/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/ENABLE_AMQP = False/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/AMQP_VERBOSE = False/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/AMQP_METRIC_NAME_IN_BODY = False/) }
    it { should contain_concat__fragment('carbon_cache_a').with_content(/ENABLE_MANHOLE = False/) }
  end

  context "arrayable parameters undefined" do
    let(:params) { {} }

    it { should contain_concat__fragment('carbon_cache_a').with(
        'order' => '20_cache_a',
        'target' => '/etc/carbon/carbon.conf',
      )
    }

    it { should contain_concat__fragment('carbon_cache_a').without_content(/BIND_PATTERNS = /) }

  end

  context "arrayable parameters single value" do
    let(:params) {{
      :bind_patterns => 'foo',
    }}

    it { should contain_concat__fragment('carbon_cache_a').with(
        'order' => '20_cache_a',
        'target' => '/etc/carbon/carbon.conf',
      )
    }

    it { should contain_concat__fragment('carbon_cache_a').with_content(/BIND_PATTERNS = foo/) }

  end

  context "arrayable parameters as array" do
    let(:params) {{
      :bind_patterns => ['foo','bar','baz']
    }}

    it { should contain_concat__fragment('carbon_cache_a').with(
        'order' => '20_cache_a',
        'target' => '/etc/carbon/carbon.conf',
      )
    }

    it { should contain_concat__fragment('carbon_cache_a').with_content(/BIND_PATTERNS = foo, bar, baz/) }
  end

  context "namevar testing" do
    describe "namevar is totally valid and fine" do
      let(:title) { 'foo_bar_42_ABC' }

      it { subject }
    end

    describe "namevar starts with two dashes" do
      let(:title) { '--hack-the-planet' }
      it {
        expect {
          should contain__concat__fragment('carbon_cache_a')
        }.to raise_error(Puppet::Error, /validate_re.*does not match/)
      }
    end

    describe "namevar has a dollar sign" do
      let(:title) { '$sohack' }
      it {
        expect {
          should contain__concat__fragment('carbon_cache_a')
        }.to raise_error(Puppet::Error, /validate_re.*does not match/)
      }
    end

    describe "namevar has a space in it" do
      let(:title) { 'foo bar fail' }

      it {
        expect {
          should contain__concat__fragment('carbon_cache_a')
        }.to raise_error(Puppet::Error, /validate_re.*does not match/)
      }
    end
  end

end
