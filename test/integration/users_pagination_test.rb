require 'test_helper'

class UsersPaginationTest < ActionDispatch::IntegrationTest
  def setup
  	@owner = users(:owner)
  end

  test "index including pagination" do
    	log_in_as(@owner)
    	get users_path
    	assert_template 'users/index'
    	assert_select 'div.pagination'
    	User.paginate(page: 1).each do |user|
    		assert_select 'a[href=?]', edit_user_path(user), text: "Edit"
    	end
  end
end
