module CloudstackResources
  class Project < Resource

    RESOURCE_NAME = 'project'

    has_many :tags
    has_many :virtual_machines

  end
end
