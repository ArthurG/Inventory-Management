class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.text :name
      t.float :cad_price
      t.float :usd_price
      t.references :purchase_category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
