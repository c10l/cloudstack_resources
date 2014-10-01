class CloudstackResources::Resource

  def initialize(properties = {})
    @conn = CloudstackResources::connection
    populate(properties)
  end

  def populate(properties)
    self.class.create_attributes(properties.keys)
    properties.each do |p|
      self.send("#{p.first}=", p.last)
    end
  end

  def self.where(params = {})
    list_method = "list_#{self::RESOURCE_NAME}s".to_sym
    resources = CloudstackResources::connection.send(list_method, params)
    resources[self::RESOURCE_NAME].collect { |p| self.new(p) }
  end

  def self.create_attributes(attributes)
    attributes.each { |attribute| attr_accessor attribute }
  end

  class << self
    alias_method :all, :where
  end

end
