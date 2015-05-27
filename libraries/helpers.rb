#
# Cookbook: rabbitmqadmin
# License: Apache 2.0
#
# Copyright 2015 Bloomberg Finance L.P.
#

module RabbitmqadminCookbook
  module Helpers
    def rabbitmqadmin_command
      opts = [
        "-u '#{username}'",
        "-p '#{password}'"
      ]
      opts << "-V '#{vhost}'" unless vhost.nil?
      opts << "-H '#{hostname}'" unless hostname.nil?
      opts << "-P #{port}" unless port.nil?

      if ssl
        opts << '-s'
        opts << "--ssl-key-file '#{ssl_key_file}'" if ssl_key_file
        opts << "--ssl-cert-file '#{ssl_cert_file}'" if ssl_cert_file
      end

      ['rabbitmqadmin', opts].flatten.join(' ')
    end
  end
end
