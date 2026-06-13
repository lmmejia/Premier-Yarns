class Cartitem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def item_total_price
    product.price * quantity.to_i
  end
  
end

