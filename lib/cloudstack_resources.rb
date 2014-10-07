require 'cloudstack_ruby_client'
require 'cloudstack_resources/version'

class CloudstackResources

  autoload 'Resource',       'cloudstack_resources/resource'
  autoload 'Conn',           'cloudstack_resources/resource/conn'
  autoload 'Project',        'cloudstack_resources/resource/project'
  autoload 'VirtualMachine', 'cloudstack_resources/resource/virtual_machine'
  autoload 'Tag',            'cloudstack_resources/resource/tag'

  def self.connection
    @connection ||= Conn.new
  end

  def self.connect
    yield connection if block_given?
    connection
  end

end
