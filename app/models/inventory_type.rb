class InventoryType < ActiveRecord::Base
	has_many :characteristics, dependent: :destroy
	accepts_nested_attributes_for :characteristics
	validates :name, presence: true
end
