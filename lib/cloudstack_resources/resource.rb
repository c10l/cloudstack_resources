module CloudstackResources
  class Resource

    RESOURCE_NAME = 'resource'

    attr_reader :cloudstack_attributes

    class_eval('extend Selectors')
    class_eval('extend Associations')

    def initialize(attributes = {})
      @cloudstack_attributes = attributes
      @klass = self.class
      @conn = CloudstackResources::connection
      populate_attributes
    end

    private

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
