require_relative 'helpers'
require 'forwardable'

class Chef::Provider::RabbitmqadminQueue < Chef::Provider::LWRPBase
  include RabbitmqadminCookbook::Helpers
  extend Forwardable
  def_delegators :@new_resource, :queue_name, :queue_options
  provides :rabbitmqadmin_queue

  use_inline_resources if defined?(use_inline_resources)
  def whyrun_supported?
    true
  end

  action :create do
    execute "rabbitmqadmin_queue[#{new_resource.name}] :create" do
      sensitive true
      command run_command('declare queue')
      environment('PATH' => '/usr/local/bin:/usr/bin')
      not_if "#{rabbitmqadmin_command} -f tsv list queues |awk '$1 ~ /^#{queue_name}$/'"
    end
  end

  action :delete do
    execute "rabbitmqadmin_queue[#{new_resource.name}] :create" do
      sensitive true
      command run_command('delete queue')
      environment('PATH' => '/usr/local/bin:/usr/bin')
      only_if "#{rabbitmqadmin_command} -f tsv list queues |awk '$1 ~ /^#{queue_name}$/'"
    end
  end

  def run_command(*args)
    opts = [
      "name='#{queue_name}'",
    ]

    new_resource.queue_options.each_pair do |key, value|
      opts << "#{key}='#{value}'"
    end

    [ rabbitmqadmin_command, args, opts ].flatten.join(' ')
  end
end
