require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
  	@owner = users(:owner)
  	@hr = users(:hr)
  	@buyer = users(:buyer)
  	@viewer = users(:viewer)
  end

  test "should redirect edit user if not logged in" do
  	get :edit, id: @hr
  	assert_not flash.empty?
  	assert_redirected_to login_path
  end 

  test "should redirect update user if not logged in" do
  	patch :update, id: @owner, user: {email: @owner.email}
  	assert_not flash.empty?
  	assert_redirected_to login_path
  end 

  test "should allow admin and hr to edit other users" do
  	log_in_as(@owner)
  	get :edit, id: @buyer
  	assert flash.empty?
  	log_in_as(@hr)
  	get :edit, id: @buyer
  	assert flash.empty?
  end

  test "should not allow hr to edit owner" do
  	log_in_as(@hr)
  	get :edit, id: @owner
  	assert_not flash.empty?
  	assert_redirected_to root_path
  end

  test "non-owner and non-hr users can't edit other users" do
  	log_in_as(@buyer)
  	get :edit, id: @owner
  	assert_not flash.empty?
  	assert_redirected_to root_path
  	log_in_as(@viewer)
  	get :edit, id: @viewer
  	assert_not flash.empty?
  	assert_redirected_to root_path
  end

  test "non-owner and non-hr users can't patch other users" do
  	log_in_as(@buyer)
  	patch :update, id: @owner, user: {email: "newemail@new.ca"}
  	assert_not flash.empty?
  	assert_redirected_to root_path
  	log_in_as(@viewer)
  	patch :update, id: @viewer, user: {email: "newemail@new.ca"}
  	assert_not flash.empty?
  	assert_redirected_to root_path
  end

  test "Should redirect index if not logged in" do
  	get :index
  	assert_redirected_to login_path
  end

   test "Should display index if logged in as any user" do
   	log_in_as(@buyer)
  	get :index
  	assert_template 'users/index'	
  end

  test "signups closed after owner exists" do
    get :new
    assert_redirected_to root_path
  end

  test "posting new user closed after owner exists" do
    assert_no_difference 'User.count' do 
      post :create, user: {
        email: "newguy@new.ca", 
        password: "password",
        password_confirmation: "password", 
        user_type: "owner"}
    end
    assert_redirected_to root_path
  end

  test "can't change own user_type" do
    log_in_as(@owner)
    patch :update, id: @owner, user: {user_type: "HR Manager"} 
    @owner.reload
    assert_equal @owner.user_type, "Owner"
    log_in_as(@hr)
    patch :update, id: @hr, user: {user_type: "HR Manager"} 
    @hr.reload
    assert_equal @hr.user_type, "HR Manager"
  end

  test "HR can't change user_type of Owner" do
    log_in_as(@hr)
    patch :update, id: @owner, user: {user_type: "HR Manager"} 
    @owner.reload
    assert_equal @owner.user_type, "Owner"
  end

  test "HR can't change user_type to Owner" do
    log_in_as(@hr)
    patch :update, id: @buyer, user: {user_type: "Owner"} 
    @buyer.reload
    assert_equal @buyer.user_type, "Buyer"
  end

  test "Regular employees can't change own user_type of others" do
    log_in_as(@buyer)
    patch :update, id: @viewer, user: {user_type: "HR Manager"} 
    @viewer.reload
    assert_equal @viewer.user_type, "Viewer"
  end
end
