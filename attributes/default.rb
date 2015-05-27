#
# Cookbook: rabbitmqadmin
# License: Apache 2.0
#
# Copyright 2015 Bloomberg Finance L.P.
#

default['rabbitmqadmin']['install_path'] = '/usr/local/bin'
default['rabbitmqadmin']['source_version'] = '3.5.0'
default['rabbitmqadmin']['source_url'] = "https://raw.githubusercontent.com/rabbitmq/rabbitmq-management/rabbitmq_v%{version}/bin/rabbitmqadmin"
default['rabbitmqadmin']['source_checksum'] = 'eddb93f835a90bb3a1e349862f8aa3451389cf3ff6d5bf05835637de6e5f12fc'
