require 'spec_helper'

describe 'graphite::relay_rule', :type => 'define' do
  let(:facts) {{
    :operatingsystem => 'Ubuntu',
    :concat_basedir => '/foo',
  }}

  let(:title) { 'production' }

  context "normal usage" do
    let(:params) {{
      :pattern => 'foo',
      :servers => '127.0.0.1:1234',
    }}

    it { should contain_concat__fragment('carbon_relay_rule_production').with(
      :target => '/etc/carbon/relay-rules.conf',
      :order => '100',
    )}

    it { should contain_concat__fragment('carbon_relay_rule_production').with_content(/\[production\]/) }
    it { should contain_concat__fragment('carbon_relay_rule_production').with_content(/pattern = foo/) }
    it { should contain_concat__fragment('carbon_relay_rule_production').with_content(/servers = 127\.0\.0\.1:1234/) }
  end

  context "order parameter" do
    let(:params) {{
      :pattern => 'foo',
      :servers => '127.0.0.1:1234',
      :order => 123,
    }}

    it { should contain_concat__fragment('carbon_relay_rule_production').with(
      :target => '/etc/carbon/relay-rules.conf',
      :order => 123,
    )}
  end

  context "servers parameter array" do
    let(:params) {{
      :pattern => 'foo',
      :servers => ['127.0.0.1:5678','127.0.0.1:5679'],
    }}

    it { should contain_concat__fragment('carbon_relay_rule_production').with_content(/servers = 127\.0\.0\.1:5678, 127\.0\.0\.1:5679/) }
  end

end
