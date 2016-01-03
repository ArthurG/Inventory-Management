require 'test_helper'

class InventoryTypeTest < ActiveSupport::TestCase
  
  test "Inventory must have valid characterisitcs" do 
  	inv = InventoryType.new(name: "abcd")
  	inv.characteristics.new
  	assert_not inv.save
  end

  test "Inventory must have valid name" do 
  	inv = InventoryType.new
  	inv.characteristics.new(name: "Brand")
  	assert_not inv.save
  end

   test "Valid inventory can be saved" do 
  	inv = InventoryType.new(name: "ABC")
  	inv.characteristics.new(name: "Brand")
  	assert inv.save
  end
end
