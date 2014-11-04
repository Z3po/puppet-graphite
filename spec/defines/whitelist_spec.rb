require 'spec_helper'

describe 'graphite::whitelist', :type => 'define' do
  let(:facts) {{
    :operatingsystem => 'Ubuntu',
    :concat_basedir => '/foo',
  }}

  let(:title) { 'foo' }

  context "whitelist one item" do
    let(:params) {{
      :pattern => "foo",
    }}

    it { should contain_concat__fragment('carbon_whitelist_foo').with(
      :target => '/etc/carbon/whitelist.conf',
      :order => 'foo',
      :content => "foo\n",
    )}
  end

  context "whitelist a bunch of items" do
    let(:params) {{
      :pattern => ['bar','baz','bat'],
    }}

    it { should contain_concat__fragment('carbon_whitelist_foo').with(
      :target => '/etc/carbon/whitelist.conf',
      :order => 'foo',
      :content => "bar\nbaz\nbat\n",
    )}
  end
end
