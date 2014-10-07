require 'cloudstack_ruby_client'
require 'cloudstack_resources/version'

module CloudstackResources

  autoload 'Conn',           'cloudstack_resources/conn'
  autoload 'Resource',       'cloudstack_resources/resource'
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
