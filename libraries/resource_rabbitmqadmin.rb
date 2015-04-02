require 'chef/resource/lwrp_base'

class Chef::Resource::Rabbitmqadmin < Chef::Resource::LWRPBase
  self.resource_name = :rabbitmqadmin
  actions :create, :delete
  default_action :create

  attribute :vhost, kind_of: String
  attribute :username, kind_of: String, required: true
  attribute :password, kind_of: String, required: true
  attribute :hostname, kind_of: String
  attribute :port, kind_of: Number
  attribute :ssl, kind_of: [TrueClass, FalseClass], default: false
  attribute :ssl_key_file, kind_of: String
  attribute :ssl_cert_file, kind_of: String

  def sensitive
    true
  end
end
