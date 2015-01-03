require "active_support/concern"
require "active_support/core_ext/module/aliasing"

module SerializeHasMany
  module Concern
    extend ActiveSupport::Concern

    class_methods do
      def serialize_has_many(attr_name, target_class, options=nil)
        using = options[:using] || raise(':using is required')
        serializer = Serializer.new(target_class, using)

        serialize attr_name, serializer
        validates_with Validators::TypeValidator, attr_name: attr_name, target_class: target_class

        define_method "#{attr_name}_with_typecast=" do |items|
          send "#{attr_name}_without_typecast=", serializer.transform(items)
        end
        alias_method_chain "#{attr_name}=", :typecast
      end
    end
  end
end
