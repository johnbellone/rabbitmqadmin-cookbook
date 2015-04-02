#
# Cookbook Name:: rabbitmqadmin
# Recipe:: default
#
# Copyright (C) 2015 Bloomberg Finance L.P.
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'python::default'

directory node['rabbitmqadmin']['install_path'] do
  recursive true
  not_if { Dir.exist?(path) }
end

# Because someone decided to be funny and not use periods in the URL.
friendly_version = node['rabbitmqadmin']['source_version'].gsub(/\./, /_/)
script = remote_file File.join(node['rabbitmqadmin']['install_path'], 'rabbitmqadmin') do
  source node['rabbitmqadmin']['source_url'] % { version: friendly_version }
  checksum node['rabbitmqadmin']['source_checksum']
  mode '0755'
  action :create_if_missing
end
