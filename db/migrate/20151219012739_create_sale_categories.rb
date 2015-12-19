class CreateSaleCategories < ActiveRecord::Migration
  def change
    create_table :sale_categories do |t|
      t.string :name
      t.text :fields

      t.timestamps null: false
    end
  end
end
