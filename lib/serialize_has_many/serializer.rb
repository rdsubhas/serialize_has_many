module SerializeHasMany
  class Serializer
    def initialize(child_class, using)
      raise "#{child_class} does not respond to attributes" unless child_class.method_defined?(:attributes)
      raise "#{using} does not implement load" unless using.respond_to?(:load)
      raise "#{using} does not implement dump" unless using.respond_to?(:dump)

      @child_class = child_class
      @using = using
    end

    def load(string)
      from_attributes @using.load(string)
    end

    def dump(items)
      @using.dump to_attributes(items)
      case items
        when nil then nil
        when Array then @using.dump(to_attributes(items))
        else raise('not an array or nil')
      end
    end

    def from_attributes(items)
      case items
        when nil then []
        when Array then items.map{ |item| item ? @child_class.new(item) : nil }
        else raise('not an array or nil')
      end
    end

    def to_attributes(items)
      case items
        when nil then nil
        when Array then items.map{ |item| item ? item.attributes : nil }
        else raise('not an array or nil')
      end
    end
  end
end
