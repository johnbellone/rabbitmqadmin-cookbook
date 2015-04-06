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
      command run_command('declare queue')
      environment('PATH' => '/usr/local/bin:/usr/bin')
    end
  end

  action :delete do
    execute "rabbitmqadmin_queue[#{new_resource.name}] :create" do
      command run_command('delete queue')
      environment('PATH' => '/usr/local/bin:/usr/bin')
    end
  end

  def run_command(*args)
    opts = [
      "--name='#{exchange_name}'",
    ]

    new_resource.exchange_options.each_pair do |key, value|
      opts << "--#{key}='#{value}'"
    end

    [ rabbitmqadmin_command, args, opts ].flatten.join(' ')
  end
end
