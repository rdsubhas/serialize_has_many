module SerializeHasMany
  class Serializer
    def initialize(model_class, using)
      raise "#{using} does not implement load" unless using.respond_to?(:load)
      raise "#{using} does not implement dump" unless using.respond_to?(:dump)

      @model_class = model_class
      @using = using
    end

    def load(string)
      cast_items @using.load(string)
    end

    def dump(items)
      case items
        when nil then nil
        when Array then @using.dump(items)
        else raise('not an array or nil')
      end
    end

    private

    def cast_items(items)
      case items
        when nil then []
        when Array then items.map{ |item| item ? @model_class.new(item) : nil }
        else raise('not an array or nil')
      end
    end
  end
end
