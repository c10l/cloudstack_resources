class CloudstackResources::Project

  def initialize(properties)
    @conn = CloudstackResources::connection
    @properties = properties
    populate(properties)
  end

  def populate(properties)
    # Create attributes from the hash's keys
  end

  def self.all
    projects = CloudstackResources::connection.list_projects
    projects['project'].collect { |p| self.new(p) }
  end

  def self.where(params = {})
    projects = CloudstackResources::connection.list_projects(params)
    projects['project'].collect { |p| self.new(p) }
  end

end
