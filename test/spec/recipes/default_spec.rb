require 'spec_helper'

describe_recipe 'rabbitmqadmin::default' do
  it { expect(chef_run).to include_recipe('python::package') }
  it { expect(chef_run).not_to create_directory('/usr/local/bin') }
  it { expect(chef_run).to render_file('/usr/local/bin/rabbitmqadmin') }
  context 'with default attributes' do
    it 'converges successfully' do
      chef_run
    end
  end
end
