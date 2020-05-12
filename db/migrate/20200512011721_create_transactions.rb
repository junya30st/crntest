class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :name
      t.integer :price
      t.integer :period
      t.references :customer, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
