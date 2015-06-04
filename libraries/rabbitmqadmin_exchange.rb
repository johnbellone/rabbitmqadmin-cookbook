#
# Cookbook: rabbitmqadmin
# License: Apache 2.0
#
# Copyright 2015 Bloomberg Finance L.P.
#
require 'poise'

class Chef::Resource::RabbitmqadminExchange < Chef::Resource
  include RabbitmqadminCookbook::Helpers
  include Poise(fused: true)
  actions(:create, :delete)
  provides(:rabbitmqadmin_exchange)

  attribute(:exchange_name, kind_of: String, name_attribute: true)
  attribute(:exchange_type, kind_of: String, default: 'topic', equal_to: %w(topic direct))
  attribute(:exchange_options, kind_of: Hash, default: {})
  attribute(:environment, kind_of: Hash, default: { 'PATH' => '/usr/local/bin:/usr/bin:/bin' })
  attribute(:vhost, kind_of: String)
  attribute(:username, kind_of: String, required: true)
  attribute(:password, kind_of: String, required: true)
  attribute(:hostname, kind_of: String)
  attribute(:port, kind_of: Integer)
  attribute(:ssl, kind_of: [TrueClass, FalseClass], default: false)
  attribute(:ssl_key_file, kind_of: String)
  attribute(:ssl_cert_file, kind_of: String)

  def command(*args)
    opts = [
      "name='#{exchange_name}'",
      "type='#{exchange_type}'"
    ]

    exchange_options.each_pair { |k, v| opts << "#{k}='#{v}'" }
    [rabbitmqadmin_command, args, opts].flatten.join(' ')
  end

  def exchange_exists?
    "#{rabbitmqadmin_command} -f tsv list exchanges | cut -f 1 | egrep -m1 -q '^#{exchange_name}$'"
  end

  action(:create) do
    notifying_block do
      execute "rabbitmqadmin declare exchange #{new_resource.exchange_name}" do
        command new_resource.command('declare exchange')
        sensitive true
        environment new_resource.environment
        not_if new_resource.exchange_exists?, environment: new_resource.environment
        guard_interpreter :default
      end
    end
  end

  action(:delete) do
    notifying_block do
      execute "rabbitmqadmin delete exchange #{new_resource.exchange_name}" do
        command new_resource.command('delete exchange')
        sensitive true
        environment new_resource.environment
        not_if new_resource.exchange_exists?, environment: new_resource.environment
        guard_interpreter :default
      end
    end
  end
end
