require_relative 'resource_rabbitmqadmin_queue'

class Chef::Resource::RabbitmqadminExchange < Chef::Resource::Rabbitmqadmin
  self.resource_name = :rabbitmqadmin_exchange

  attribute :exchange_name, kind_of: String, name_attribute: true, required: true
  attribute :exchange_type, kind_of: String, default: 'topic', required: true, regex: /^(topic|direct)$/
end
