require 'cloudstack_ruby_client'
require 'cloudstack_resources/version'

class CloudstackResources

  autoload 'Resource', 'cloudstack_resources/resource'
  autoload 'Conn',     'cloudstack_resources/conn'
  autoload 'Project',  'cloudstack_resources/project'
  autoload 'VM',       'cloudstack_resources/vm'

  def self.connection
    @connection ||= CloudstackResources::Conn.new
  end

  def self.connect
    yield connection if block_given?
    connection
  end

end
