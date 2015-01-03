require 'rails_helper'

describe Invoice do

  it 'should create' do
    t = Invoice.create line_items: 'test'
    expect(t.line_items).to eq 'test'
  end

end
