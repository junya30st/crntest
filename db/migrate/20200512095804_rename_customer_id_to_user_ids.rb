class RenameCustomerIdToUserIds < ActiveRecord::Migration[5.2]
  def change
    rename_column :cards, :customer_id, :user_id
  end
end
