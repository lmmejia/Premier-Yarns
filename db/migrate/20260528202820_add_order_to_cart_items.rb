class AddOrderToCartItems < ActiveRecord::Migration[8.1]
  def change
    add_reference :cartitems, :order, foreign_key: true
  end
end
