require 'spec_helper'

describe 'graphite::blacklist', :type => 'define' do
  let(:facts) {{
    :operatingsystem => 'Ubuntu',
    :concat_basedir => '/foo',
  }}

  let(:title) { 'foo' }

  context "blacklist one item" do
    let(:params) {{
      :pattern => "foo",
    }}

    it { should contain_concat__fragment('carbon_blacklist_foo').with(
      :target => '/etc/carbon/blacklist.conf',
      :order => 'foo',
      :content => "foo\n",
    )}
  end

  context "blacklist a bunch of items" do
    let(:params) {{
      :pattern => ['bar','baz','bat'],
    }}

    it { should contain_concat__fragment('carbon_blacklist_foo').with(
      :target => '/etc/carbon/blacklist.conf',
      :order => 'foo',
      :content => "bar\nbaz\nbat\n",
    )}
  end
end

