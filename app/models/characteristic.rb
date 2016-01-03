class Characteristic < ActiveRecord::Base
  belongs_to :inventory_type
  validates :name, presence: true
end
