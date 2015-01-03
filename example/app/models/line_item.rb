class LineItem
  include ActiveModel::Model

  attr_accessor :item
  attr_accessor :price
  attr_accessor :quantity
end
