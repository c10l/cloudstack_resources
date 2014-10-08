module CloudstackResources
  class Tag < Resource

    resource_name :tag

    belongs_to :resource

    def resource
      resource_class = "CloudstackResources::#{self.resourcetype}".constantize
      resource_class.where( { :id => @resourceid } )
    end

  end
end
