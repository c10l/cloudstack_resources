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
      this = self.name.demodulize.downcase

      define_method(resource_type) { klass.where( :"#{this}id" => self.id ) }
    end

    def self.belongs_to(resource_type)
      klass = "CloudstackResources::#{resource_type.to_s.camelize}".constantize

      define_method(resource_type) do
        klass.select!( :id => self.cloudstack_attributes['"#{resource_type}id"'] )
      end
    end

    def self.resource_name(name)
      code = %{ RESOURCE_NAME = '#{name.to_s}' }
      class_eval(code)
    end

    def populate_attributes
      attributes = @cloudstack_attributes.keys
      attributes.each do |attribute|
        next if respond_to?(attribute.to_sym) && !instance_eval("@#{attribute}.nil?")
        populate_attribute(attribute)
        self.class.def_attribute_getter(attribute)
      end
    end

    def populate_attribute(attribute)
      code = %{ @#{attribute} = @cloudstack_attributes['#{attribute}'] }
      instance_eval(code)
    end

    def self.def_attribute_getter(attribute)
      return nil if instance_methods.include?(attribute.to_sym)
      code = %{ attr_reader :#{attribute} }
      class_eval(code)
    end

  end
end
