module CloudstackResources
  class VirtualMachine < Resource

    resource_name :virtual_machine

    belongs_to :project

  end
end
