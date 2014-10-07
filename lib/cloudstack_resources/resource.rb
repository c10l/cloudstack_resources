module CloudstackResources
  class Resource

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

    def populate_attributes
      @cloudstack_attributes.keys.each do |attribute|
        next if self.respond_to?(attribute.to_sym)
        @klass.send(:attr_accessor, attribute)
        setter = "#{attribute}=".to_sym
        self.send(setter, @cloudstack_attributes[attribute.to_s])
      end
    end

  end
end
