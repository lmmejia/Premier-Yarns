class ShopperController < ApplicationController
  def index
    @allproducts = Product.order(:name) 
  end
end