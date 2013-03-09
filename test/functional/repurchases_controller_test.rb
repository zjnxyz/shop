require 'test_helper'

class RepurchasesControllerTest < ActionController::TestCase
  setup do
    @repurchase = repurchases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:repurchases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create repurchase" do
    assert_difference('Repurchase.count') do
      post :create, repurchase: { actual_sum: @repurchase.actual_sum, amount: @repurchase.amount, remark: @repurchase.remark, sum: @repurchase.sum }
    end

    assert_redirected_to repurchase_path(assigns(:repurchase))
  end

  test "should show repurchase" do
    get :show, id: @repurchase
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @repurchase
    assert_response :success
  end

  test "should update repurchase" do
    put :update, id: @repurchase, repurchase: { actual_sum: @repurchase.actual_sum, amount: @repurchase.amount, remark: @repurchase.remark, sum: @repurchase.sum }
    assert_redirected_to repurchase_path(assigns(:repurchase))
  end

  test "should destroy repurchase" do
    assert_difference('Repurchase.count', -1) do
      delete :destroy, id: @repurchase
    end

    assert_redirected_to repurchases_path
  end
end
