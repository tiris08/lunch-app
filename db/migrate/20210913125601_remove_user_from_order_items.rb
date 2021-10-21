class RemoveUserFromOrderItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :order_items, :user_id, :integer
  end
end
