require_relative 'resource_rabbitmqadmin_queue'

class Chef::Resource::RabbitmqadminQueue < Chef::Resource::Rabbitmqadmin
  self.resource_name = :rabbitmqadmin_queue

  attribute :queue_name, kind_of: String, name_attribute: true, required: true
end
