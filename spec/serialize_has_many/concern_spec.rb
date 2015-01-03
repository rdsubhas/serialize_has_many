require 'spec_helper'
require 'json'

class ConcernTestModel
  # AR compatibility
  def self.serialize(*args)
    # noop, we're not saving/loading anything here
  end

  include ActiveModel::Model
  include SerializeHasMany::Concern

  attr_accessor :data
  serialize_has_many :data, TestChildModel, using: JSON, validate: true
end

describe SerializeHasMany::Concern do
  it 'should invoke type validator' do
    record = ConcernTestModel.new
    expect_any_instance_of(SerializeHasMany::Validators::TypeValidator).
      to receive(:validate).with(record)
    expect(record).to be_valid
  end

  it 'should invoke nested validator' do
    record = ConcernTestModel.new
    expect_any_instance_of(SerializeHasMany::Validators::NestedValidator).
      to receive(:validate).with(record)
    expect(record).to be_valid
  end

  it 'should override setter' do
    record = ConcernTestModel.new
    record.data = [{ name: 1}]
    expect(record.data.first).to be_kind_of TestChildModel
    expect(record.data.first.name).to eq 1
  end
end
