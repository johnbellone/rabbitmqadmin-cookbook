#
# Cookbook: rabbitmqadmin
# License: Apache 2.0
#
# Copyright 2015 Bloomberg Finance L.P.
#
include_recipe 'python::package'

directory node['rabbitmqadmin']['install_path'] do
  recursive true
  not_if { Dir.exist?(path) }
end

cookbook_file File.join(node['rabbitmqadmin']['install_path'], 'rabbitmqadmin') do
  source 'rabbitmqadmin.py'
  mode '0755'
  action :create_if_missing
end
