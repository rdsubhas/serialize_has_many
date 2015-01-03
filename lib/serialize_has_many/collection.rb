module SerializeHasMany
  class Collection
    include Enumerable
    extend Forwardable

    def_delegators :@items, :[], :each, :size, :count, :empty?, :blank?, :present?, :to_s

    def initialize(model_clazz, items)
      @model_clazz = model_clazz
      @items = cast_items(items)
    end

    def <<(item)
      @items << cast_item(item)
    end

    def []=(index, item)
      @items[index] = cast_item(item)
    end

    def dup
      self.class.new(@model_clazz, @items)
    end

    def serialized_attributes
      @items.map do |item|
        item ? item.attributes : nil
      end
    end

    def ==(other)
      other.kind_of?(self.class) && other.send(:equals?, @model_clazz, @items)
    end

    private

    def equals?(model_clazz, items)
      @model_clazz == model_clazz && @items == items
    end

    def cast_items(items)
      raise('items is not an array') unless items.nil? || items.kind_of?(Array)
      (items || []).map { |item| cast_item(item) }
    end

    def cast_item(item)
      case item
        when @model_clazz then item
        when Hash then @model_clazz.new(item)
        when nil then nil
        else raise("item not type of #{@model_clazz}")
      end
    end
  end
end