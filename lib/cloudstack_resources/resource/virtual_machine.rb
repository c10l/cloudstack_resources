module CloudstackResources
  class VirtualMachine < Resource

    RESOURCE_NAME = 'virtual_machine'

    def project
      @project ||= Project.where( { :id => self.projectid } )
    end

  end
end
