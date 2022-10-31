require 'rails_helper'

RSpec.describe 'the items index page' do
  before :each do
    @safeway = Supermarket.create!(name: 'Safeway', location: 'Broadway and Campbell')
    @frys = Supermarket.create!(name: 'Frys', location: 'Grant and Swan')
    @milk = Item.create!(name: 'Milk', price: 4, supermarket_id: @safeway.id)
    @eggs = Item.create!(name: 'Eggs', price: 2, supermarket_id: @safeway.id)
    @bread = Item.create!(name: 'Bread', price: 3, supermarket_id: @safeway.id)
    @bacon = Item.create!(name: 'Bacon', price: 8, supermarket_id: @frys.id)
    @cheese = Item.create!(name: 'Cheese', price: 5, supermarket_id: @frys.id)
    @sally = Customer.create!(name: 'Sally Shopper')
    @billy = Customer.create!(name: 'Billy Buyer')
    @customer_item1 = CustomerItem.create!(customer_id: @sally.id, item_id: @milk.id)
    @customer_item2 = CustomerItem.create!(customer_id: @sally.id, item_id: @bread.id)
    @customer_item3 = CustomerItem.create!(customer_id: @sally.id, item_id: @cheese.id)
    @customer_item4 = CustomerItem.create!(customer_id: @billy.id, item_id: @eggs.id)
    @customer_item5 = CustomerItem.create!(customer_id: @billy.id, item_id: @bacon.id)
    @customer_item6 = CustomerItem.create!(customer_id: @billy.id, item_id: @cheese.id)
    @customer_item7 = CustomerItem.create!(customer_id: @billy.id, item_id: @milk.id)
  end

  it 'lists name/price/supermarket/customer count of all items' do
    visit '/items'
    
    within "#item_#{@milk.id}" do
      expect(page).to have_content(@milk.name)
      expect(page).to have_content(@milk.price)
      expect(page).to have_content(@safeway.name)
      expect(page).to have_content('Number of Customers Purchased: 2')
    end

    within "#item_#{@eggs.id}" do
      expect(page).to have_content(@eggs.name)
      expect(page).to have_content(@eggs.price)
      expect(page).to have_content(@safeway.name)
      expect(page).to have_content('Number of Customers Purchased: 1')
    end

    within "#item_#{@bread.id}" do
      expect(page).to have_content(@bread.name)
      expect(page).to have_content(@bread.price)
      expect(page).to have_content(@safeway.name)
      expect(page).to have_content('Number of Customers Purchased: 1')
    end

    within "#item_#{@bacon.id}" do
      expect(page).to have_content(@bacon.name)
      expect(page).to have_content(@bacon.price)
      expect(page).to have_content(@frys.name)
      expect(page).to have_content('Number of Customers Purchased: 1')
    end

    within "#item_#{@cheese.id}" do
      expect(page).to have_content(@cheese.name)
      expect(page).to have_content(@cheese.price)
      expect(page).to have_content(@frys.name)
      expect(page).to have_content('Number of Customers Purchased: 2')
    end

  end
  
end