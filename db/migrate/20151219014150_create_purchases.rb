class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.string :name
      t.string :category
      t.float :cad_price
      t.float :usd_price
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
