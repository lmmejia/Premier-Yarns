class AddUserToOrders < ActiveRecord::Migration[8.1]
  def change
    reversible do |dir|
      dir.up { execute "DELETE FROM orders" }
    end

    add_reference :orders, :user, null: false, foreign_key: true
  end
end
