require "active_support/concern"

module SerializeHasMany
  module Concern
    extend ActiveSupport::Concern

    class_methods do
      def serialize_has_many(attr_name, model_clazz, options=nil)
        using = options[:using] || raise(':using is required')
        serialize attr_name, Serializer.new(model_clazz, using)
      end
    end
  end
end
