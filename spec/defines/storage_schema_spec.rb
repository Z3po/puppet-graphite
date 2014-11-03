require 'spec_helper'

describe 'graphite::storage_schema', :type => 'define' do
  let(:facts) {{ 
    :operatingsystem => 'Ubuntu',
    :concat_basedir => '/foo',
  }}

  let(:title) { 'staging' }

  context "defaults" do
    let(:params) {{
      :pattern    => 'foo',
      :retentions => 'bar',
    }}

    it { should contain_concat__fragment('storage_schema_staging').with(
      :target => '/etc/carbon/storage_schemas.conf',
      :order  => 100,
    )}

    it { should contain_concat__fragment('storage_schema_staging').with_content(/\[staging\]/) }
    it { should contain_concat__fragment('storage_schema_staging').with_content(/pattern = foo/) }
    it { should contain_concat__fragment('storage_schema_staging').with_content(/retentions = bar/) }
  end
  
  context "order is specified" do
    let(:params) {{
      :pattern    => 'foo',
      :retentions => 'bar',
      :order      => 42,
    }}

    it { should contain_concat__fragment('storage_schema_staging').with(
      :target => '/etc/carbon/storage_schemas.conf',
      :order  => 42,
    )}
  end

  context "arrayable parameters array" do
    let(:params) {{
      :pattern    => 'foo',
      :retentions => ['bar', 'baz', 'bat'],
    }}

    it { should contain_concat__fragment('storage_schema_staging').with(
      :target => '/etc/carbon/storage_schemas.conf',
      :order  => 100,
    )}

    it { should contain_concat__fragment('storage_schema_staging').with_content(/\[staging\]/) }
    it { should contain_concat__fragment('storage_schema_staging').with_content(/pattern = foo/) }
    it { should contain_concat__fragment('storage_schema_staging').with_content(/retentions = bar, baz, bat/) }
  end

end
