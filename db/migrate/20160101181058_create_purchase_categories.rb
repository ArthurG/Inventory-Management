class CreatePurchaseCategories < ActiveRecord::Migration
  def change
    create_table :purchase_categories do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
