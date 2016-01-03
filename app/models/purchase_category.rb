class PurchaseCategory < ActiveRecord::Base
	validates :name, presence: true
	has_many :purchases, :dependent => :destroy
end
