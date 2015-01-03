class Invoice < ActiveRecord::Base
  include SerializeHasMany::Concern
  serialize_has_many :line_items, LineItem, using: JSON, validate: true
end
