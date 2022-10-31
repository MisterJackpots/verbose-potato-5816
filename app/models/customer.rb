class Customer < ApplicationRecord
  has_many :customer_items
  has_many :items, through: :customer_items
end