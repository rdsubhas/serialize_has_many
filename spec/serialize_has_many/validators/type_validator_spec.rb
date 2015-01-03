require 'spec_helper'

describe SerializeHasMany::Validators::TypeValidator do
  subject do
    described_class.new(attr_name: :children, child_class: OpenStruct)
  end

  it 'should allow nil' do
    record = TestParentModel.new(children: nil)
    subject.validate record
    expect(record.errors).to be_empty
  end

  it 'should allow empty array' do
    record = TestParentModel.new(children: [])
    subject.validate record
    expect(record.errors).to be_empty
  end

  it 'should allow items with nil' do
    record = TestParentModel.new(children: [nil, nil, nil])
    subject.validate record
    expect(record.errors).to be_empty
  end

  it 'should allow items with correct data type' do
    record = TestParentModel.new(children: [OpenStruct.new, OpenStruct.new, OpenStruct.new])
    subject.validate record
    expect(record.errors).to be_empty
  end

  it 'should not allow primitives' do
    record = TestParentModel.new(children: '')
    subject.validate record
    expect(record.errors[:children]).to include /is not an array/
  end

  it 'should not allow hash' do
    record = TestParentModel.new(children: {})
    subject.validate record
    expect(record.errors[:children]).to include /is not an array/
  end

  it 'should not items with wrong data type' do
    record = TestParentModel.new(children: [ {}, '', 1 ])
    subject.validate record
    expect(record.errors[:children].count).to be 3
    expect(record.errors[:children].uniq.first).to match /is not of type/
  end
end
