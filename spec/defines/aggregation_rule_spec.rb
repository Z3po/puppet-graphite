require 'spec_helper'

describe 'graphite::aggregation_rule', :type => 'define' do
  let(:facts) {{
    :operatingsystem => 'Ubuntu',
    :concat_basedir => '/foo',
  }}

  let(:title) { 'something' }

  context "default parameters" do
    let(:params) {{
      :output_template => 'foo',
      :method => 'bar',
      :input_pattern => 'baz',
    }}

    it { should contain_concat__fragment('aggregation_rule_something').with(
      :target => '/etc/carbon/aggregation-rules.conf',
      :content => 'foo (60) bar baz'
    )}
  end

  context "non-default frequency" do
    let(:params) {{
      :output_template => 'foo',
      :frequency => 123,
      :method => 'bar',
      :input_pattern => 'baz',
    }}

    it { should contain_concat__fragment('aggregation_rule_something').with(
      :target => '/etc/carbon/aggregation-rules.conf',
      :content => 'foo (123) bar baz'
    )}
  end
end
