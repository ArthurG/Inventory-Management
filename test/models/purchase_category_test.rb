require 'test_helper'

class PurchaseCategoryTest < ActiveSupport::TestCase
  test "Must have category name" do 
  	purchase_category = PurchaseCategory.new
  	assert_not purchase_category.save
  	purchase_category.name = "    "
  	assert_not purchase_category.save
  end
end
