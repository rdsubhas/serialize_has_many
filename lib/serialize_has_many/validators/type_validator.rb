require 'active_model/validator'

module SerializeHasMany
  module Validators
    class TypeValidator < ActiveModel::Validator
      def attr_name
        options[:attr_name]
      end

      def child_class
        options[:child_class]
      end

      def attributes
        [ attr_name ]
      end

      def validate(record)
        items = record.send attr_name

        if items.nil?
          nil
        elsif items.kind_of?(Array)
          validate_each(record, items)
        else
          record.errors.add "#{attr_name}", "is not an array"
        end
      end

      def validate_each(record, items)
        items.each do |item|
          unless item.nil? || item.kind_of?(child_class)
            record.errors.add "#{attr_name}", "item is not of type #{child_class}"
          end
        end
      end
    end
  end
end
