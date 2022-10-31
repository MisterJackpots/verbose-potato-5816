require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :supermarket }
    it { should have_many :customer_items }
    it { should have_many(:customers).through(:customer_items) }
  end

  before :each do
    @safeway = Supermarket.create!(name: 'Safeway', location: 'Broadway and Campbell')
    @frys = Supermarket.create!(name: 'Frys', location: 'Grant and Swan')
    @milk = Item.create!(name: 'Milk', price: 4, supermarket_id: @safeway.id)
    @eggs = Item.create!(name: 'Eggs', price: 2, supermarket_id: @safeway.id)
    @bread = Item.create!(name: 'Bread', price: 3, supermarket_id: @frys.id)
    @bacon = Item.create!(name: 'Bacon', price: 8, supermarket_id: @frys.id)
  end

  describe 'model methods' do
    describe '#where_from' do
      it 'returns the name of supermarket where the item was purchased' do
        expect(@milk.where_from).to eq(@safeway.name)
        expect(@eggs.where_from).to eq(@safeway.name)
        expect(@bread.where_from).to eq(@frys.name)
        expect(@bacon.where_from).to eq(@frys.name)
      end
    end

    describe '#purchase_count' do
      it 'returns the number of customers that purcahsed an item' do
        @sally = Customer.create!(name: 'Sally Shopper')
        @billy = Customer.create!(name: 'Billy Buyer')
        @customer_item1 = CustomerItem.create!(customer_id: @sally.id, item_id: @milk.id)

        expect(@milk.purchase_count).to eq(1)

        @customer_item2 = CustomerItem.create!(customer_id: @billy.id, item_id: @milk.id)

        expect(@milk.purchase_count).to eq(2)
      end
    end
  end
end
