module CloudstackResources
  module Selectors

    def where(params = {})
      list_method = "list_#{self::RESOURCE_NAME}s".to_sym
      resources = CloudstackResources::connection.send(list_method, params)
      return [] if resources == {}
      resources[self::RESOURCE_NAME.gsub('_','')].collect { |p| self.new(p) }
    end

    def select!(params = {})
      self.where(params).first
    end

    alias_method :all, :where

  end
end
