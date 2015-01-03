class TestChildModel
  include ActiveModel::Model
  attr_accessor :name

  validates_presence_of :name

  def attributes
    { name: name }
  end
end
