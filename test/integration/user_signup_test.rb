require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
 
 	def setup
 		@hr = users(:hr)
		@owner = users(:owner)
		@buyer = users(:buyer)
 	end

  test "invalid signup information" do
  	User.destroy_all
  	get signup_path
  	assert_no_difference 'User.count' do 
  		post users_path, user: {
  			email: "", 
  			password: "123456", 
  			password_confirmation: "123456", 
  			user_type: "Owner"}
  	end
  	assert_template 'users/new'
  end
	
	test "valid signup test" do
  	User.destroy_all
		get signup_path
		assert_difference 'User.count' do
			post_via_redirect users_path user: {
				email: "realguy@abc.com", 
				password: "123456",
				password_confirmation: "123456",
				user_type: "Owner"
			}
		end
		assert_equal flash[:success], "Your account has been created for Ruby on Rails inventory management"
    assert_template 'users/show'
		assert_select '.alert-success', "Your account has been created for Ruby on Rails inventory management"
	end

	test "Generic user can't create new owner" do
		log_in_as(@buyer)
		assert_equal @buyer.user_type, "Buyer"
		get signup_path
		assert_no_difference 'User.count' do
			post users_path user: {
				email: "realguy@abc.com", 
				user_type: "Buyer",
				password: "123456",
				password_confirmation: "123456"
			}
		end
	end

	test "HR Manager can't create new owner" do
		log_in_as(@hr)
		assert_equal @hr.user_type, "HR Manager"
		get signup_path
		assert_no_difference 'User.count' do
			post users_path user: {
				email: "realguy@abc.com", 
				user_type: "Owner",
				password: "123456",
				password_confirmation: "123456"
			}
		end
	end

	test "HR Manager can create new employee" do
		log_in_as(@hr)
		assert_equal @hr.user_type, "HR Manager"
		assert_difference 'User.count' do
			post users_path user: {
				email: "realgu123y@abc.com", 
				user_type: "Buyer",
				password: "123456",
				password_confirmation: "123456"
			}
		end
	end

	test "Owner can create new owner" do
		log_in_as(@owner)
		assert_equal @owner.user_type, "Owner"
		assert_difference 'User.count' do
			post users_path user: {
				email: "realguy@abc.com", 
				user_type: "Owner",
				password: "123456",
				password_confirmation: "123456"
			}
		end
	end  

	test "Owner signup new Viewer" do
		log_in_as(@owner)
		assert_equal @owner.user_type, "Owner"
		assert_difference 'User.count' do
			post users_path user: {
				email: "realguy@abc.com", 
				user_type: "Viewer",
				password: "123456",
				password_confirmation: "123456"
			}
		end
	end  

end
