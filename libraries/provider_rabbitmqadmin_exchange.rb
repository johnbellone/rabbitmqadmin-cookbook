require_relative 'helpers'
require 'forwardable'

class Chef::Provider::RabbitmqadminExchange < Chef::Provider::LWRPBase
  include RabbitmqadminCookbook::Helpers
  extend Forwardable
  def_delegators :@new_resource, :exchange_name, :exchange_type, :exchange_options
  provides :rabbitmqadmin_exchange

  use_inline_resources if defined?(use_inline_resources)
  def whyrun_supported?
    true
  end

  action :create do
    execute "rabbitmqadmin_exchange[#{new_resource.name}] :create" do
      command run_command('declare exchange')
      environment('PATH' => '/usr/local/bin:/usr/bin')
    end
  end

  action :delete do
    execute "rabbitmqadmin_exchange[#{new_resource.name}] :create" do
      command run_command('delete exchange')
      environment('PATH' => '/usr/local/bin:/usr/bin')
    end
  end

  def run_command(*args)
    opts = [
      "--name='#{exchange_name}'",
      "--type='#{exchange_type}'"
    ]

    new_resource.exchange_options.each_pair do |key, value|
      opts << "--#{key}='#{value}'"
    end

    [ rabbitmqadmin_command, args, opts ].flatten.join(' ')
  end
end
