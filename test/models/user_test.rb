require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@user = User.new(email: "arthur@gmail.ca", user_type: "Owner", password: "123456", password_confirmation: "123456")
  end

	test "should be valid" do
		assert @user.valid?
	end

	test "should email set" do
		@user.email = "           "
		assert_not @user.valid?
	end

	test "should have valid email" do
    valid_addresses = %w[user@example @foo.COM A_US-ER@frog.]
    valid_addresses.each do |address|
    	@user.email = address
		assert_not @user.valid? "#{address} should be valid"    	
    end
	end

	test "should accept valid address" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
    	@user.email = valid_address
    	assert @user.valid?, '#{valid_address.inspect} should be valid'
    end
	end

	test "should not have duplicate users" do
		dup = @user.dup
		dup.email = @user.email.upcase
		@user.save
		assert_not dup.valid?
	end

	test "password isn't blank" do
		@user.password = @user.password_confirmation = " " * 6
		assert_not @user.valid?
	end

	test "password min 6 chars" do
		@user.password = @user.password_confirmation = "a" * 5
		assert_not @user.valid?
	end

	test "authenticated? returns false with nil digest" do
		assert_not @user.authenticated?('')
	end



end
