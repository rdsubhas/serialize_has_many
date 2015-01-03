class LineItem
  include ActiveModel::Model

  attr_accessor :name
  attr_accessor :price
  attr_accessor :quantity

  validates :name, presence: true
  validates :price, numericality: { greater_than: 0 }, presence: true
  validates :quantity, numericality: { greater_than: 0 }, presence: true

  def attributes
    { name: name, price: price, quantity: quantity }
  end
end
