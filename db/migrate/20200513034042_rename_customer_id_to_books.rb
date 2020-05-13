class RenameCustomerIdToBooks < ActiveRecord::Migration[5.2]
  def change
    rename_column :transactions, :customer_id, :user_id
  end
end
