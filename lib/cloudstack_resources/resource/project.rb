module CloudstackResources
  class Project < Resource

    RESOURCE_NAME = 'project'

    has_many :tags
    has_many :virtual_machines

    def tags
      @tags ||= Tag.where( { :projectid => self.id } )
    end

    def virtual_machines
      @virtual_machines ||= VirtualMachine.where( { :projectid => self.id } )
    end

  end
end
