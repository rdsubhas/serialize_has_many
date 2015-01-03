require 'spec_helper'

describe SerializeHasMany::Validators::NestedValidator do
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

  it 'should allow valid items' do
    record = TestParentModel.new(children: [TestChildModel.new(name: 'test'), TestChildModel.new(name: 'test')])
    subject.validate record
    expect(record.errors).to be_empty
  end

  it 'should not allow invalid items' do
    record = TestParentModel.new(children: [TestChildModel.new(name: 'test'), TestChildModel.new])
    subject.validate record
    expect(record.errors).to_not be_empty
    expect(record.errors['children.name']).to be_present
  end
end
