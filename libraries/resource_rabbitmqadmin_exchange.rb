class Chef::Resource::RabbitmqadminExchange < Chef::Resource::LWRPBase
  self.resource_name = :rabbitmqadmin_exchange
  actions :create, :delete
  default_action :create
  provides :rabbitmqadmin_exchange

  attribute :vhost, kind_of: String
  attribute :username, kind_of: String, required: true
  attribute :password, kind_of: String, required: true
  attribute :hostname, kind_of: String
  attribute :port, kind_of: Integer
  attribute :ssl, kind_of: [TrueClass, FalseClass], default: false
  attribute :ssl_key_file, kind_of: String
  attribute :ssl_cert_file, kind_of: String

  attribute :exchange_name, kind_of: String, name_attribute: true, required: true
  attribute :exchange_type, kind_of: String, default: 'topic', required: true, regex: /^(topic|direct)$/
  attribute :exchange_options, kind_of: Hash, default: {}, required: true
end
