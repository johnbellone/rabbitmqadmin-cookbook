require_relative 'provider_rabbitmqadmin'

class Chef::Provider::RabbitmqadminQueue < Chef::Provider::Rabbitmqadmin
  extend Forwardable
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

    # TODO: (jbellone) Figure out best way to parse options here.

    # The parent class will build command-line options for login and
    # all that fancy jazz. Simply care about the specifics.
    [ super, command_type, opts ].flatten.join(' ')
  end
end
