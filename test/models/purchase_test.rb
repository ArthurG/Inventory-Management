require 'test_helper'

class PurchaseTest < ActiveSupport::TestCase

	def setup
		@wheel_cat = purchase_categories(:wheel)
		@brake_cat = purchase_categories(:brake)
  end

  test "should be valid purchase" do
  	p = Purchase.new(name: "ABCDE Wheel 1000", cad_price: 25.50, usd_price: 36.45, purchase_category: @wheel_cat)
    assert p.valid?
  end

  test "purchase requires all fields present" do
  	p = Purchase.new(name: "", cad_price: 25.50, usd_price: 36.45, purchase_category: @wheel_cat)
  	assert_not p.valid?
  	p = Purchase.new(name: "abc", usd_price: 36.45, purchase_category: @wheel_cat)
  	assert_not p.valid?
  	p = Purchase.new(name: "abc", cad_price: 36.45, purchase_category: @wheel_cat)
  	assert_not p.valid?
  	p = Purchase.new(name: "abc", cad_price: 36.45, usd_price: 36.45)
  	assert_not p.valid?
  end
end
