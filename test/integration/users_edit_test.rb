require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
  	@user = users(:owner)
  end

  test "invalid fields edit users" do
  	log_in_as(@user)
  	get edit_user_path(@user)
  	assert_template 'users/edit'
  	patch user_path(@user), user: {email: "",
  																	password: "bar",
  																	password_confirmation: "bar"}
  	assert_template 'users/edit'
  end 

  test "valid edit users" do
  	newemail = "testemail12345@fake.fake"
  	log_in_as(@user)
  	get edit_user_path(@user)
  	assert_template 'users/edit'
  	patch user_path(@user), user: {email: newemail,
  																	password: "",
  																	password_confirmation: ""}
  	assert_template 'users/show'
  	assert_not flash.empty?
  	get root_path
  	assert flash.empty?
  	@user.reload
  	assert_equal @user.email, newemail
  end



 
end
