require 'chef/provider/lwrp_base'
require 'forwardable'

class Chef::Provider::Rabbitmqadmin < Chef::Provider::LWRPBase
  extend Forwardable
  def_delegators :@new_resource, :sensitive

  use_inline_resources if defined?(use_inline_resources)
  provides :rabbitmqadmin

  def whyrun_enabled?
    true
  end

  def command
    opts = [
      "-u '#{new_resource.username}'",
      "-p '#{new_resource.password}'"
    ]
    opts << "-V '#{new_resource.vhost}'" if new_resource.vhost
    opts << "-H '#{new_resource.hostname}'" if new_resource.hostname
    opts << "-P #{new_resource.port}" if new_resource.port
    opts << "-s" if new_resource.ssl
    opts << "--ssl-key-file '#{new_resource.ssl_key_file}'"
    opts << "--ssl-cert-file '#{new_resource.ssl_cert_file}'"

    [ 'rabbitmqadmin', opts ].flatten.join(' ')
  end
end
