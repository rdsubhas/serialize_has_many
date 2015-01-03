require "active_support/concern"
require "active_support/core_ext/module/aliasing"

module SerializeHasMany
  module Concern
    extend ActiveSupport::Concern

    class_methods do
      def serialize_has_many(attr_name, child_class, options=nil)
        using = options[:using] || raise(':using is required')
        serializer = Serializer.new(child_class, using)

        serialize attr_name, serializer
        validates_with Validators::TypeValidator, attr_name: attr_name, child_class: child_class

        define_method "#{attr_name}=" do |items|
          write_attribute attr_name, serializer.from_attributes(items)
        end

        if options[:validate] == true
          validates_with Validators::NestedValidator, attr_name: attr_name, child_class: child_class
        end
      end
    end
  end
end
