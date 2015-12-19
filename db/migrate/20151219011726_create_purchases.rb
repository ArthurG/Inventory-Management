class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.string :name
      t.integer :quantity
      t.string :category
      t.float :cadprice
      t.float :usdprice
      t.timestamp :added

      t.timestamps null: false
    end
  end
end
