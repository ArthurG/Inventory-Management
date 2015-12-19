require 'test_helper'

class SaleCategoriesControllerTest < ActionController::TestCase
  setup do
    @sale_category = sale_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sale_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sale_category" do
    assert_difference('SaleCategory.count') do
      post :create, sale_category: { fields: @sale_category.fields, name: @sale_category.name }
    end

    assert_redirected_to sale_category_path(assigns(:sale_category))
  end

  test "should show sale_category" do
    get :show, id: @sale_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sale_category
    assert_response :success
  end

  test "should update sale_category" do
    patch :update, id: @sale_category, sale_category: { fields: @sale_category.fields, name: @sale_category.name }
    assert_redirected_to sale_category_path(assigns(:sale_category))
  end

  test "should destroy sale_category" do
    assert_difference('SaleCategory.count', -1) do
      delete :destroy, id: @sale_category
    end

    assert_redirected_to sale_categories_path
  end
end
