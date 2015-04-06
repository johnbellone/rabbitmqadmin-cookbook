require_relative 'helpers'
require 'forwardable'

class Chef::Provider::RabbitmqadminQueue < Chef::Provider::LWRPBase
  include RabbitmqadminCookbook::Helpers
  extend Forwardable

  use_inline_resources if defined?(use_inline_resources)
  def_delegators :@new_resource, :queue_name, :queue_options
  provides :rabbitmqadmin_queue

  def command_type
    case @new_resource.action
    when :create
      return 'declare queue'
    when :delete
      return 'delete queue'
    end
  end

  def command
    opts = [
      "--name='#{queue_name}'"
    ]

    @new_resource.queue_options.each_pair do |key, value|
      opts << "--#{key}='#{value}'"
    end

    # The parent class will build command-line options for login and
    # all that fancy jazz. Simply care about the specifics.
    [ build_command, command_type, opts ].flatten.join(' ')
  end
end
