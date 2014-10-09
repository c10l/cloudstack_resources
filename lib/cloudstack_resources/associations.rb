module CloudstackResources
  module Associations

    private

    def has_many(resource_type)
      klass = "CloudstackResources::#{resource_type.to_s.singularize.camelize}".constantize
      this = self.name.demodulize.downcase

      define_method(resource_type) { klass.where( :"#{this}id" => self.id ) }
    end

    def belongs_to(resource_type)
      klass = "CloudstackResources::#{resource_type.to_s.camelize}".constantize

      define_method(resource_type) do
        klass.select!( :id => self.cloudstack_attributes['"#{resource_type}id"'] )
      end
    end

  end
end
