require_relative 'provider_rabbitmqadmin'
require 'forwardable'

class Chef::Provider::RabbitmqadminExchange < Chef::Provider::Rabbitmqadmin
  extend Forwardable
  def_delegators :@new_resource, :exchange_name, :exchange_type, :exchange_options
  provides :rabbitmqadmin_exchange

  def command_type
    case @new_resource.action
    when :create
      return 'declare exchange'
    when :delete
      return 'delete exchange'
    end
  end

  def command
    opts = [
      "--name='#{exchange_name}'",
      "--type='#{exchange_type}'"
    ]

    # TODO: (jbellone) Figure out best way to parse options here.

    # The parent class will build command-line options for login and
    # all that fancy jazz. Simply care about the specifics.
    [ super, command_type, opts ].flatten.join(' ')
  end
end
