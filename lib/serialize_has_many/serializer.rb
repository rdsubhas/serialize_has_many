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
      attributes = to_attributes(items)
      attributes ? @using.dump(attributes) : nil
    end

    def from_attributes(items)
      case items
        when nil then []
        when Array then items.map{ |item| from_hash(item) }
        else raise('not an array or nil')
      end
    end

    def to_attributes(items)
      case items
        when nil then nil
        when Array then items.map{ |item| to_hash(item) }
        else raise('not an array or nil')
      end
    end

    def from_hash(item)
      case item
        when nil then nil
        when Hash then @child_class.new(item)
        when @child_class then item
        else raise('item is of invalid type')
      end
    end

    def to_hash(item)
      case item
        when nil then nil
        when Hash then item
        when @child_class then item.attributes
        else raise('item is of invalid type')
      end
    end
  end
end
