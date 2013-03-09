require 'test_helper'

class SayControllerTest < ActionController::TestCase
  test "should get find_p_by_brand" do
    get :find_p_by_brand
    assert_response :success
  end

  test "should get find_p_by_category" do
    get :find_p_by_category
    assert_response :success
  end

end
