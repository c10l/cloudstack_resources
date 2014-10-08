module CloudstackResources
  class VirtualMachine < Resource

    RESOURCE_NAME = 'virtual_machine'

    belongs_to :project

  end
end
