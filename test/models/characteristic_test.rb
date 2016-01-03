require 'test_helper'

class CharacteristicTest < ActiveSupport::TestCase
	def setup
		@inv_type = inventory_types(:one)
	end
  
	test "valid charactarstic can be saved" do
		a = Characteristic.new(name: "abcd", inventory_type: @inv_type)
		assert a.save
		a = Characteristic.new(name: "1234", inventory_type: @inv_type)
		assert a.save
	end

  test "charactaristic needs name" do 
  	a = Characteristic.new(name: "", inventory_type: @inv_type)
  	assert_not a.save
	end	


end
