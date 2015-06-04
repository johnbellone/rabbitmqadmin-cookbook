#
# Cookbook: rabbitmqadmin
# License: Apache 2.0
#
# Copyright 2015 Bloomberg Finance L.P.
#
require 'poise'

class Chef::Resource::RabbitmqadminQueue < Chef::Resource
  include RabbitmqadminCookbook::Helpers
  include Poise(fused: true)
  actions(:create, :destroy)
  provides(:rabbitmqadmin_queue)

  attribute(:queue_name,
            kind_of: String,
            name_attribute: true,
            cannot_be: :empty)
  attribute(:queue_options,
            kind_of: Hash,
            default: {})
  attribute(:run_environment,
            kind_of: Hash,
            default: { 'PATH' => '/usr/local/bin:/usr/bin:/bin' })

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
      "name='#{queue_name}'",
    ]

    queue_options.each_pair { |k, v| opts << "#{k}='#{v}'" }

    [rabbitmqadmin_command, args, opts].flatten.join(' ')
  end

  def queue_exists?
    "#{rabbitmqadmin_command} -f tsv list queues | cut -f 1 | egrep -m1 -q '^#{queue_name}$'"
  end

  action(:create) do
    notifying_block do
      execute "rabbitmqadmin declare queue #{new_resource.queue_name}" do
        command new_resource.command('declare queue')
        sensitive true
        environment new_resource.run_environment
        not_if new_resource.queue_exists?, environment: new_resource.run_environment
        guard_interpreter :default
      end
    end
  end

  action(:delete) do
    notifying_block do
      execute "rabbitmqadmin delete queue #{new_resource.queue_name}" do
        command new_resource.command('delete queue')
        sensitive true
        environment new_resource.run_environment
        only_if new_resource.queue_exists?, environment: new_resource.run_environment
        guard_interpreter :default
      end
    end
  end
end
