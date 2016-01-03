require 'test_helper'

class PurchaseCategoriesControllerTest < ActionController::TestCase
  setup do
    @purchase_category = purchase_categories(:wheel)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:purchase_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create purchase_category" do
    assert_difference('PurchaseCategory.count') do
      post :create, purchase_category: { name: @purchase_category.name }
    end

    assert_redirected_to purchase_category_path(assigns(:purchase_category))
  end

  test "should show purchase_category" do
    get :show, id: @purchase_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @purchase_category
    assert_response :success
  end

  test "should update purchase_category" do
    patch :update, id: @purchase_category, purchase_category: { name: @purchase_category.name }
    assert_redirected_to purchase_category_path(assigns(:purchase_category))
  end

  test "should destroy purchase_category" do
    assert_difference('PurchaseCategory.count', -1) do
      delete :destroy, id: @purchase_category
    end

    assert_redirected_to purchase_categories_path
  end
end
