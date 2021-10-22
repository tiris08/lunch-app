class AddOrderToOrderItem < ActiveRecord::Migration[6.1]
  def change
    add_reference :order_items, :order, null: false, default: 1, foreign_key: true
  end
end
