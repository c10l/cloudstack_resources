module CloudstackResources
  class Resource

    RESOURCE_NAME = 'resource'

    attr_reader :cloudstack_attributes

    def initialize(attributes = {})
      @conn = CloudstackResources::connection
      @cloudstack_attributes = attributes
      @klass = self.class
      populate_attributes
    end

    def self.where(params = {})
      list_method = "list_#{self::RESOURCE_NAME}s".to_sym
      resources = CloudstackResources::connection.send(list_method, params)
      return [] if resources == {}
      resources[self::RESOURCE_NAME.gsub('_','')].collect { |p| self.new(p) }
    end

    def self.select!(params = {})
      self.where(params).first
    end

    class << self
      alias_method :all, :where
    end

    private

    def self.has_many(resource_type)
      klass = "CloudstackResources::#{resource_type.to_s.singularize.camelize}".constantize
      current_resource = self.name.demodulize.downcase

      code = %Q{
        def #{resource_type}
          #{klass}.where( :#{current_resource}id => self.id )
        end
      }
      class_eval(code)
    end

    def self.belongs_to(resource_type)
      klass = "CloudstackResources::#{resource_type.to_s.camelize}".constantize
      current_resource = self::RESOURCE_NAME

      code = %Q{
        def #{resource_type}
          #{klass}.select!( :id => self.cloudstack_attributes['#{resource_type}id'] )
        end
      }
      class_eval(code)
    end

    def self.resource_name(name)
      class_eval("RESOURCE_NAME = '#{name.to_s}'")
    end

    def populate_attributes
      attributes = @cloudstack_attributes.keys.delete_if { |attr| respond_to? attr.to_sym }
      attributes.each do |attribute|
        populate = %Q{ @#{attribute} = @cloudstack_attributes['#{attribute}'] }
        instance_eval(populate)
        create_getter = %Q{ attr_reader :#{attribute} }
        @klass.class_eval(create_getter)
      end
    end

  end
end
