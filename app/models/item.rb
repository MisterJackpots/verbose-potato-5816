class Item < ApplicationRecord
  belongs_to :supermarket
  has_many :customer_items
  has_many :customers, through: :customer_items

  def where_from
    supermarket.name
  end

  def purchase_count
    customers.count
  end
end