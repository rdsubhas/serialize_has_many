require 'spec_helper'

describe SerializeHasMany::Validators::TypeValidator do
  subject do
    described_class.new(serialized_attribute: :data, serialized_class: OpenStruct)
  end

  it 'should allow nil' do
    record = TestModel.new(data: nil)
    subject.validate record
    expect(record.errors).to be_empty
  end

  it 'should allow empty array' do
    record = TestModel.new(data: [])
    subject.validate record
    expect(record.errors).to be_empty
  end

  it 'should allow items with nil' do
    record = TestModel.new(data: [nil, nil, nil])
    subject.validate record
    expect(record.errors).to be_empty
  end

  it 'should allow items with correct data type' do
    record = TestModel.new(data: [OpenStruct.new, OpenStruct.new, OpenStruct.new])
    subject.validate record
    expect(record.errors).to be_empty
  end

  it 'should not allow primitives' do
    record = TestModel.new(data: '')
    subject.validate record
    expect(record.errors[:data]).to include /is not an array/
  end

  it 'should not allow hash' do
    record = TestModel.new(data: {})
    subject.validate record
    expect(record.errors[:data]).to include /is not an array/
  end

  it 'should not items with wrong data type' do
    record = TestModel.new(data: [ {}, '', 1 ])
    subject.validate record
    expect(record.errors[:data].count).to be 3
    expect(record.errors[:data].uniq.first).to match /is not of type/
  end
end
