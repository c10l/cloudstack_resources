module CloudstackResources
  class VirtualMachine < Resource

    resource_name :virtual_machine

    belongs_to :project

    def destroy( options = { :expunge => false } )
      raise "Valid options: { :expunge => bool }" if options.keys != [ :expunge ]
      @conn.send( :destroy_virtual_machine, options.merge( { :id => self.id} ) )
    end

  end
end
