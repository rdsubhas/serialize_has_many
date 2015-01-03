require "active_support/concern"

module SerializeHasMany
  module Concern
    extend ActiveSupport::Concern

    class_methods do
      def serialize_has_many(attr_name, model_clazz, options=nil)
        serialize attr_name, Serializer.new
      end
    end
  end
end
