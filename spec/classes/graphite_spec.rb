require 'spec_helper'

describe 'graphite' do
  let(:default_facts) {{
    :concat_basedir => '/foo'
  }}
  context 'supported operating systems' do
    ['Ubuntu'].each do |operatingsystem|
      describe "graphite class without any parameters on #{operatingsystem}" do
        let(:params) {{ }}
        let(:facts) {
          {
            :operatingsystem => operatingsystem,
          }.merge default_facts
        }

        it { should compile.with_all_deps }

        it { should contain_class('graphite::params') }

        it { should contain_class('graphite::install').that_comes_before('graphite::config') }
        it { should contain_package('graphite-carbon') }

        it { should contain_class('graphite::config') }
        it { should contain_concat('/etc/carbon/carbon.conf').with(
          :owner => '_graphite',
          :group => '_graphite',
          :mode  => '0600',
          :warn  => true,
        )}
        it { should contain_concat('/etc/carbon/storage_schemas.conf').with(
          :owner => '_graphite',
          :group => '_graphite',
          :mode  => '0600',
          :warn  => true,
        )}
        it { should contain_concat('/etc/carbon/storage_aggregation.conf').with(
          :owner => '_graphite',
          :group => '_graphite',
          :mode  => '0600',
          :warn  => true,
        )}

        it { should contain_class('graphite::cache_globals') }
        it { should contain_concat__fragment('carbon_cache_globals').with(
          :target => '/etc/carbon/carbon.conf',
          :order  => '10_cache_globals',
        )}

        it { should contain_file('/etc/init.d/carbon-cache').that_requires('Package[graphite-carbon]') }
        it { should contain_file('/etc/init.d/carbon-cache').with(
          :ensure => 'absent',
        )}

        it { should contain_file('/etc/default/graphite-carbon').that_requires('Package[graphite-carbon]') }
        it { should contain_file('/etc/default/graphite-carbon').with(
          :ensure => 'absent',
        )}

      end
      
    end
  end

  context "config file contents" do
    let(:facts) {
      {
        :operatingsystem => 'Ubuntu'
      }.merge default_facts
    }

    describe "cache_globals content with default parameters" do
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/\[cache\]/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(%r{STORAGE_DIR\s+= /var/lib/graphite}) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(%r{CONF_DIR\s+= /etc/carbon}) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(%r{LOG_DIR\s+= /var/log/carbon}) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(%r{PID_DIR\s+= /var/run}) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(%r{LOCAL_DATA_DIR\s+= /var/lib/graphite/whisper}) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/ENABLE_LOGROTATION = False/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/USER = _graphite/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/MAX_CACHE_SIZE = inf/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/MAX_UPDATES_PER_SECOND = 500/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/# MAX_UPDATES_PER_SECOND_ON_SHUTDOWN = /) }
      it { should contain_concat__fragment('carbon_cache_globals').without_content(/\n[^#]*MAX_UPDATES_PER_SECOND_ON_SHUTDOWN = /) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/MAX_CREATES_PER_MINUTE = 50/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/LINE_RECEIVER_INTERFACE = 0\.0\.0\.0/) }
      it { should contain_concat__fragment('carbon_cache_globals').without_content(/LINE_RECEIVER_PORT/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/ENABLE_UDP_LISTENER = False/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/UDP_RECEIVER_INTERFACE = 0\.0\.0\.0/) }
      it { should contain_concat__fragment('carbon_cache_globals').without_content(/UDP_RECEIVER_PORT/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/PICKLE_RECEIVER_INTERFACE = 0\.0\.0\.0/) }
      it { should contain_concat__fragment('carbon_cache_globals').without_content(/PICKLE_RECEIVER_PORT/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/LOG_LISTENER_CONNECTIONS = True/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/USE_INSECURE_UNPICKLER = False/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/CACHE_QUERY_INTERFACE = 0\.0\.0\.0/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/USE_FLOW_CONTROL = True/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/LOG_UPDATES = False/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/LOG_CACHE_HITS = False/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/LOG_CACHE_QUEUE_SORTS = True/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/CACHE_WRITE_STRATEGY = sorted/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/WHISPER_AUTOFLUSH = False/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/WHISPER_SPARSE_CREATE = False/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/WHISPER_FALLOCATE_CREATE = True/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/WHISPER_LOCK_WRITES = False/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/USE_WHITELIST = False/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/CARBON_METRIC_PREFIX = carbon/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/CARBON_METRIC_INTERVAL = 60/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/ENABLE_AMQP = False/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/AMQP_VERBOSE = False/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/AMQP_HOST = localhost/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/AMQP_PORT = 5672/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(%r{AMQP_VHOST = /}) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/AMQP_USER = guest/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/AMQP_PASSWORD = guest/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/AMQP_EXCHANGE = graphite/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/AMQP_METRIC_NAME_IN_BODY = False/) }
      it { should contain_concat__fragment('carbon_cache_globals').without_content(/\n[^#]*BIND_PATTERNS/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/ENABLE_MANHOLE = False/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/MANHOLE_INTERFACE = 127\.0\.0\.1/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/MANHOLE_PORT = 7222/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/MANHOLE_USER = admin/) }
      it { should contain_concat__fragment('carbon_cache_globals').without_content(/MANHOLE_PUBLIC_KEY =/) }
    end

    describe "cache_globals section with all options set" do
      let(:params) {{
        :storage_dir                        => '/foo/lib/graphite',
        :conf_dir                           => '/foo/etc/carbon',
        :log_dir                            => '/foo/log/carbon',
        :pid_dir                            => '/foo/run/carbon',
        :local_data_dir                     => '/foo/lib/graphite/whisper',
        :user                               => 'foo',
        :max_cache_size                     => 12345,
        :max_updates_per_second             => 12346,
        :max_updates_per_second_on_shutdown => 12347,
        :max_creates_per_minute             => 12348,
        :line_receiver_interface            => '10.1.2.42',
        :udp_receiver_interface             => '10.1.2.43',
        :pickle_receiver_interface          => '10.1.2.44',
        :cache_query_interface              => '10.1.2.45',
        :cache_write_strategy               => 'flail',
        :carbon_metric_prefix               => 'aoeuhtns',
        :carbon_metric_interval             => 12349,
        :amqp_host                          => '10.1.2.46',
        :amqp_port                          => 12350,
        :amqp_vhost                         => '/htnsueoa',
        :amqp_user                          => 'bar',
        :amqp_password                      => 'baz',
        :amqp_exchange                      => 'bat',
        :manhole_interface                  => '10.1.2.47',
        :manhole_port                       => 12351,
        :manhole_user                       => 'qux',
        :manhole_public_key                 => 'UEOAHTNS',
      }}

      it { should contain_concat__fragment('carbon_cache_globals').with_content(%r{STORAGE_DIR\s+= /foo/lib/graphite}) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(%r{CONF_DIR\s+= /foo/etc/carbon}) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(%r{LOG_DIR\s+= /foo/log/carbon}) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(%r{PID_DIR\s+= /foo/run/carbon}) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(%r{LOCAL_DATA_DIR\s+= /foo/lib/graphite/whisper}) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/USER = foo/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/MAX_CACHE_SIZE = 12345/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/MAX_UPDATES_PER_SECOND = 12346/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/MAX_UPDATES_PER_SECOND_ON_SHUTDOWN = 12347/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/MAX_CREATES_PER_MINUTE = 12348/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/LINE_RECEIVER_INTERFACE = 10\.1\.2\.42/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/UDP_RECEIVER_INTERFACE = 10\.1\.2\.43/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/PICKLE_RECEIVER_INTERFACE = 10\.1\.2\.44/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/CACHE_QUERY_INTERFACE = 10\.1\.2\.45/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/CACHE_WRITE_STRATEGY = flail/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/CARBON_METRIC_PREFIX = aoeuhtns/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/CARBON_METRIC_INTERVAL = 12349/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/AMQP_HOST = 10\.1\.2\.46/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/AMQP_PORT = 12350/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(%r{AMQP_VHOST = /htnsueoa}) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/AMQP_USER = bar/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/AMQP_PASSWORD = baz/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/AMQP_EXCHANGE = bat/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/MANHOLE_INTERFACE = 10\.1\.2\.47/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/MANHOLE_PORT = 12351/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/MANHOLE_USER = qux/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/MANHOLE_PUBLIC_KEY = UEOAHTNS/) }
    end

    describe "cache_globals section with all boolean options true" do
      let(:params) {{
        :enable_logrotation       => true,
        :enable_udp_listener      => true,
        :log_listener_connections => true,
        :use_insecure_unpickler   => true,
        :use_flow_control         => true,
        :log_updates              => true,
        :log_cache_hits           => true,
        :log_cache_queue_sorts    => true,
        :whisper_autoflush        => true,
        :whisper_sparse_create    => true,
        :whisper_fallocate_create => true,
        :whisper_lock_writes      => true,
        :use_whitelist            => true,
        :enable_amqp              => true,
        :amqp_verbose             => true,
        :amqp_metric_name_in_body => true,
        :enable_manhole           => true,
      }}

      it { should contain_concat__fragment('carbon_cache_globals').with_content(/ENABLE_LOGROTATION = True/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/ENABLE_UDP_LISTENER = True/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/LOG_LISTENER_CONNECTIONS = True/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/USE_INSECURE_UNPICKLER = True/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/USE_FLOW_CONTROL = True/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/LOG_UPDATES = True/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/LOG_CACHE_HITS = True/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/LOG_CACHE_QUEUE_SORTS = True/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/WHISPER_AUTOFLUSH = True/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/WHISPER_SPARSE_CREATE = True/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/WHISPER_FALLOCATE_CREATE = True/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/WHISPER_LOCK_WRITES = True/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/USE_WHITELIST = True/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/ENABLE_AMQP = True/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/AMQP_VERBOSE = True/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/AMQP_METRIC_NAME_IN_BODY = True/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/ENABLE_MANHOLE = True/) }
    end

    describe "cache_globals section with all boolean options false" do
      let(:params) {{
        :enable_logrotation       => false,
        :enable_udp_listener      => false,
        :log_listener_connections => false,
        :use_insecure_unpickler   => false,
        :use_flow_control         => false,
        :log_updates              => false,
        :log_cache_hits           => false,
        :log_cache_queue_sorts    => false,
        :whisper_autoflush        => false,
        :whisper_sparse_create    => false,
        :whisper_fallocate_create => false,
        :whisper_lock_writes      => false,
        :use_whitelist            => false,
        :enable_amqp              => false,
        :amqp_verbose             => false,
        :amqp_metric_name_in_body => false,
        :enable_manhole           => false,
      }}

      it { should contain_concat__fragment('carbon_cache_globals').with_content(/ENABLE_LOGROTATION = False/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/ENABLE_UDP_LISTENER = False/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/LOG_LISTENER_CONNECTIONS = False/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/USE_INSECURE_UNPICKLER = False/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/USE_FLOW_CONTROL = False/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/LOG_UPDATES = False/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/LOG_CACHE_HITS = False/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/LOG_CACHE_QUEUE_SORTS = False/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/WHISPER_AUTOFLUSH = False/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/WHISPER_SPARSE_CREATE = False/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/WHISPER_FALLOCATE_CREATE = False/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/WHISPER_LOCK_WRITES = False/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/USE_WHITELIST = False/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/ENABLE_AMQP = False/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/AMQP_VERBOSE = False/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/AMQP_METRIC_NAME_IN_BODY = False/) }
      it { should contain_concat__fragment('carbon_cache_globals').with_content(/ENABLE_MANHOLE = False/) }
    end

    describe "cache_globals section with arrayable values as single values" do
      let(:params) {{
        :bind_patterns => 'foo',
      }}

      it { should contain_concat__fragment('carbon_cache_globals').with_content(/BIND_PATTERNS = foo/) }
    end
    
    describe "cache_globals section with arrayable values as arrays" do
      let(:params) {{
        :bind_patterns => ['foo','bar','baz']
      }}

      it { should contain_concat__fragment('carbon_cache_globals').with_content(/BIND_PATTERNS = foo, bar, baz/) }
    end

  end

  context 'unsupported operating system' do
    describe 'graphite class without any parameters on Solaris/Nexenta' do
      let(:facts) {
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }.merge default_facts
      }

      it { expect { should contain_package('graphite') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
