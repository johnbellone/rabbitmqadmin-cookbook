require 'spec_helper'

describe file('/usr/local/bin/rabbitmqadmin') do
  it { should exist }
  it { should be_file }
  it { should be_grouped_into 'root' }
  it { should be_owned_by 'root' }
  it { should be_mode '0755' }
end
