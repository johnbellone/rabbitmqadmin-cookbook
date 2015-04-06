#
# Cookbook Name:: rabbitmqadmin
# Recipe:: default
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
# All rights reserved - Do Not Redistribute
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
