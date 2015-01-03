require 'active_model/validator'

module SerializeHasMany
  module Validators
    class TypeValidator < ActiveModel::Validator
      def attr_name
        options[:attr_name]
      end

      def target_class
        options[:target_class]
      end

      def attributes
        [ attr_name ]
      end

      def validate(record)
        items = record.send attr_name

        if items.nil?
          nil
        elsif items.kind_of?(Array)
          items.each_with_index do |item, index|
            unless item.nil? || item.kind_of?(target_class)
              record.errors.add "#{attr_name}", "item is not of type #{target_class}"
            end
          end
        else
          record.errors.add "#{attr_name}", "is not an array"
        end
      end
    end
  end
end
