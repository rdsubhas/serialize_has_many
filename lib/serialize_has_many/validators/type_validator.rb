require 'active_model/validator'

module SerializeHasMany
  module Validators
    class TypeValidator < ActiveModel::Validator
      def serialized_attribute
        options[:serialized_attribute]
      end

      def serialized_class
        options[:serialized_class]
      end

      def attributes
        [ serialized_attribute ]
      end

      def validate(record)
        items = record.send serialized_attribute

        if items.nil?
          nil
        elsif items.kind_of?(Array)
          items.each_with_index do |item, index|
            unless item.nil? || item.kind_of?(serialized_class)
              record.errors.add "#{serialized_attribute}", "item is not of type #{serialized_class}"
            end
          end
        else
          record.errors.add "#{serialized_attribute}", "is not an array"
        end
      end
    end
  end
end
