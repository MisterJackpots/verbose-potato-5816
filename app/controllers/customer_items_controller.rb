class CustomerItemsController < ApplicationController
  def update
    customer = Customer.find(params[:id])
    item = Item.find(params[:item_id])
    CustomerItem.create!(customer_id: customer.id, item_id: item.id)
    redirect_to "/customers/#{customer.id}"
  end
end