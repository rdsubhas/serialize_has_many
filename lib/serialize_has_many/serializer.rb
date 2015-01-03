module SerializeHasMany
  class Serializer
    attr_accessor :model_class
    attr_accessor :using

    def initialize(model_class, options={})
      @model_class = model_class
      @using = options[:using]

      raise "#{model_class} cannot read attributes" unless model_class.method_defined?(:attributes)

      raise "#{using} does not respond to load" unless using.respond_to?(:load)
      raise "#{using} does not respond to dump" unless using.respond_to?(:dump)
    end

    def load(string)
      items = using.load(string)
      items = [] unless items.kind_of? Array
      Collection.new model_class, items
    end

    def dump(items)
      raise('items does not have correct type') unless items.kind_of?(Collection)
      using.dump(items)
    end
  end
end
