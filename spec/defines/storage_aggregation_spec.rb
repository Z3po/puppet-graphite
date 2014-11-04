require 'spec_helper'

describe 'graphite::storage_aggregation', :type => 'define' do
  let(:facts) {{
    :operatingsystem => 'Ubuntu',
    :concat_basedir  => '/foo',
  }}

  let(:title) { 'production' }

  context "defaults" do
    let(:params) {{
      :pattern => 'foo',
    }}

    it { should contain_concat__fragment('storage_aggregation_production').with(
      :target => '/etc/carbon/storage-aggregation.conf',
      :order   => 100,
    )}

    it { should contain_concat__fragment('storage_aggregation_production').with_content(/\[production\]/) }
    it { should contain_concat__fragment('storage_aggregation_production').with_content(/pattern = foo/) }
    it { should contain_concat__fragment('storage_aggregation_production').without_content(/xFilesFactor = /) }
    it { should contain_concat__fragment('storage_aggregation_production').without_content(/aggregationMethod = /) }
  end

  context "all parameters exist" do
    let(:params) {{
      :pattern           => 'foo',
      :xFilesFactor      => 'bar',
      :aggregationMethod => 'baz',
      :order             => '42',
    }}

    it { should contain_concat__fragment('storage_aggregation_production').with(
      :target => '/etc/carbon/storage-aggregation.conf',
      :order   => 42,
    )}

    it { should contain_concat__fragment('storage_aggregation_production').with_content(/\[production\]/) }
    it { should contain_concat__fragment('storage_aggregation_production').with_content(/pattern = foo/) }
    it { should contain_concat__fragment('storage_aggregation_production').with_content(/xFilesFactor = bar/) }
    it { should contain_concat__fragment('storage_aggregation_production').with_content(/aggregationMethod = baz/) }
  end
end
