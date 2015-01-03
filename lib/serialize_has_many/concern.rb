require "active_support/concern"

module SerializeHasMany
  module Concern
    extend ActiveSupport::Concern

    class_methods do
      def serialize_has_many(attr_name, target_class, options=nil)
        using = options[:using] || raise(':using is required')
        serialize attr_name, Serializer.new(target_class, using)
        validates_with Validators::TypeValidator, attr_name: attr_name, target_class: target_class
      end
    end
  end
end
