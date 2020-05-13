class ChangeCustomersToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_table :customers, :users
  end
end
