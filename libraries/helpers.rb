module RabbitmqadminCookbook
  module Helpers
    def rabbitmqadmin_command
      opts = [
        "-u '#{new_resource.username}'",
        "-p '#{new_resource.password}'"
      ]
      opts << "-V '#{new_resource.vhost}'" if new_resource.vhost
      opts << "-H '#{new_resource.hostname}'" if new_resource.hostname
      opts << "-P #{new_resource.port}" if new_resource.port

      if new_resource.ssl
        opts << '-s'
        opts << "--ssl-key-file '#{new_resource.ssl_key_file}'" if new_resource.ssl_key_file
        opts << "--ssl-cert-file '#{new_resource.ssl_cert_file}'" if new_resource.ssl_cert_file
      end

      [ 'rabbitmqadmin', opts ].flatten.join(' ')
    end
  end
end
