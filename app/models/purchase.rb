class Purchase < ActiveRecord::Base
  belongs_to :purchase_category
  validates :name, presence: true
  validates :cad_price, presence: true
  validates :usd_price, presence: true
  validates :purchase_category, presence: true
end
