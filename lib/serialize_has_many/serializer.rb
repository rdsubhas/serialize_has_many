module SerializeHasMany
  class Serializer
    def initialize(model_class, options=nil)
      @model_class = model_class
      @options = options || {}

      raise "#{@options[:using]} does not respond to load" unless @options[:using].respond_to?(:load)
      raise "#{@options[:using]} does not respond to dump" unless @options[:using].respond_to?(:dump)
    end

    def load(string)
      string
    end

    def dump(obj)
      obj
    end
  end
end
