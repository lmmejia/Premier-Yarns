class AddQuantityToCartitems < ActiveRecord::Migration[8.1]
  def change
    add_column :cartitems, :quantity, :integer
  end
end
