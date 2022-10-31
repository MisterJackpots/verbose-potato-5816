class ItemsController < ApplicationController
  def index
    @items = Item.all
    # require 'pry'; binding.pry
  end
end