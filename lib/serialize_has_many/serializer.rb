module SerializeHasMany
  class Serializer
    attr_reader :model_class
    attr_reader :using

    def initialize(model_class, using)
      raise "#{model_class} does not implement attributes" unless model_class.method_defined?(:attributes)
      raise "#{using} does not implement load" unless using.respond_to?(:load)
      raise "#{using} does not implement dump" unless using.respond_to?(:dump)

      @model_class = model_class
      @using = using
    end

    def load(string)
      items = using.load(string)
      items = [] unless items.kind_of? Array
      Collection.new model_class, items
    end

    def dump(items)
      raise('items does not have correct type') unless items.nil? || items.kind_of?(Collection)
      using.dump(items)
    end
  end
end
