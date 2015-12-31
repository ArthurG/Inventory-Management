require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
  	get signup_path
  	assert_no_difference 'User.count' do 
  		post users_path, user: {
  			email: "", 
  			password: "123456", 
  			password_confirmation: "123456", 
  			user_type: "admin"}
  	end
  	assert_template 'users/new'
  end
	
	test "valid signup test" do
		get signup_path
		assert_difference 'User.count' do
			post_via_redirect users_path user: {
				email: "realguy@abc.com", 
				password: "123456",
				password_confirmation: "123456",
				user_type: "manager"
			}
		end
		assert_equal flash[:success], "Your account has been created for Ruby on Rails inventory management"
    assert_template 'users/show'
		assert_select '.alert-success', "Your account has been created for Ruby on Rails inventory management"
		assert is_logged_in?
	end

end
