require 'rails_helper'

RSpec.describe 'the customers show page' do
  before :each do
    @safeway = Supermarket.create!(name: 'Safeway', location: 'Broadway and Campbell')
    @milk = Item.create!(name: 'Milk', price: 4, supermarket_id: @safeway.id)
    @eggs = Item.create!(name: 'Eggs', price: 2, supermarket_id: @safeway.id)
    @bread = Item.create!(name: 'Bread', price: 3, supermarket_id: @safeway.id)
    @bacon = Item.create!(name: 'Bacon', price: 8, supermarket_id: @safeway.id)
    @sally = Customer.create!(name: 'Sally Shopper')
    @billy = Customer.create!(name: 'Billy Buyer')
    @customer_item1 = CustomerItem.create!(customer_id: @sally.id, item_id: @milk.id)
    @customer_item2 = CustomerItem.create!(customer_id: @sally.id, item_id: @bread.id)
    @customer_item3 = CustomerItem.create!(customer_id: @billy.id, item_id: @eggs.id)
    @customer_item4 = CustomerItem.create!(customer_id: @billy.id, item_id: @bacon.id)
  end

  it 'displays the customers name' do
    visit "/customers/#{@sally.id}"

    expect(page).to have_content(@sally.name)
  end

  xit 'displays a list of all items' do
    visit "/customers/#{@sally.id}"

    expect(page).to have_content(@milk.name)
    expect(page).to have_content(@bread.name)
    expect(page).to_not have_content(@eggs.name)
    expect(page).to_not have_content(@bacon.name)
  end

  xit 'display each items name/price/supermarket' do
    visit "/customers/#{@sally.id}"

    within "#items_#{@customer_item1}" do
      expect(page).to have_content(@milk.name)
      expect(page).to have_content(@milk.price)
      expect(page).to have_content(@safeway.name)
    end
  end
end