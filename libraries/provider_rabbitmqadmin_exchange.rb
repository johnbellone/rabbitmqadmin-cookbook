require_relative 'provider_rabbitmqadmin'

class Chef::Provider::RabbitmqadminExchange < Chef::Provider::Rabbitmqadmin
  extend Forwardable
  def_delegators :@new_resource, :exchange_name, :exchange_type
  provides :rabbitmqadmin_exchange

  def command

  end
end
