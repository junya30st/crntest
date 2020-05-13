class AddNumberToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :number, :integer
  end
end
