class CreateSaleItems < ActiveRecord::Migration
  def change
    create_table :sale_items do |t|
      t.string :brand
      t.string :model
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
