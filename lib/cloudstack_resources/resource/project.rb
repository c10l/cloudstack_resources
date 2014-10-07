class CloudstackResources
  class Project < Resource

    RESOURCE_NAME = 'project'

    CHILD_RESOURCES = [
      :tags,
      :virtual_machines,
    ]

    def tags
      @tags ||= Tag.where( { :projectid => self.id } )
    end

    def virtual_machines
      @virtual_machines ||= VirtualMachine.where( { :projectid => self.id } )
    end

  end
end
