require 'rails_helper'

describe TestModel do
  it 'should create' do
    t = TestModel.create data: 'test'
    expect(t.data).to eq 'test'
  end
end
