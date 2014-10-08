module CloudstackResources
  class Project < Resource

    resource_name :project

    has_many :tags
    has_many :virtual_machines

  end
end
