require 'rails_helper'

describe Invoice do

  it 'should create' do
    item = LineItem.new(name: 'test', price: 10, quantity: 1)
    invoice = Invoice.create! line_items: [item]

    invoice = Invoice.find invoice.id
    expect(invoice.line_items.count).to eq 1
    expect(invoice.line_items[0]).to_not be item
    expect(invoice.line_items[0].attributes).to eq item.attributes
  end

  it 'should create from attributes' do
    item = LineItem.new(name: 'test', price: 10, quantity: 1)
    invoice = Invoice.create! line_items: [item.attributes]

    invoice = Invoice.find invoice.id
    expect(invoice.line_items.count).to eq 1
    expect(invoice.line_items[0]).to_not be item
    expect(invoice.line_items[0].attributes).to eq item.attributes
  end

  it 'should validate' do
    item = LineItem.new
    invoice = Invoice.new line_items: [item]

    expect(invoice).to_not be_valid
    expect(invoice.errors['line_items.name']).to_not be_empty
    expect(invoice.errors['line_items.price']).to_not be_empty
    expect(invoice.errors['line_items.quantity']).to_not be_empty
  end

  it 'should update' do
    item = LineItem.new(name: 'test', price: 10, quantity: 1)
    invoice = Invoice.create! line_items: [item]

    item.name = 'test 2'
    invoice.line_items = [item]
    invoice.save!

    invoice = Invoice.find invoice.id
    expect(invoice.line_items[0]).to_not be item
    expect(invoice.line_items[0].attributes).to eq item.attributes
  end

  it 'should update from attributes' do
    item = LineItem.new(name: 'test', price: 10, quantity: 1)
    invoice = Invoice.create! line_items: [item]

    item.name = 'test 2'
    invoice.line_items = [item.attributes]
    invoice.save!

    invoice = Invoice.find invoice.id
    expect(invoice.line_items[0]).to_not be item
    expect(invoice.line_items[0].attributes).to eq item.attributes
  end

end
