module CloudstackResources
  class Resource

    HAS_MANY = []

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
      HAS_MANY << resource_type
    end

    def populate_attributes
      @cloudstack_attributes.keys.each do |attribute|
        next if @klass::HAS_MANY.include?(attribute.to_sym)
        @klass.send(:attr_accessor, attribute)
        setter = "#{attribute}=".to_sym
        self.send(setter, @cloudstack_attributes[attribute.to_s])
      end
    end

  end
end
