require 'test_helper'

class StaffsControllerTest < ActionController::TestCase
  setup do
    @staff = staffs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:staffs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create staff" do
    assert_difference('Staff.count') do
      post :create, staff: { address: @staff.address, allowance: @staff.allowance, birthday: @staff.birthday, card_id: @staff.card_id, email: @staff.email, img_url: @staff.img_url, low_salary: @staff.low_salary, name: @staff.name, number: @staff.number, phone: @staff.phone, pinyin_initials: @staff.pinyin_initials, remark: @staff.remark, sex: @staff.sex, start_work_time: @staff.start_work_time }
    end

    assert_redirected_to staff_path(assigns(:staff))
  end

  test "should show staff" do
    get :show, id: @staff
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @staff
    assert_response :success
  end

  test "should update staff" do
    put :update, id: @staff, staff: { address: @staff.address, allowance: @staff.allowance, birthday: @staff.birthday, card_id: @staff.card_id, email: @staff.email, img_url: @staff.img_url, low_salary: @staff.low_salary, name: @staff.name, number: @staff.number, phone: @staff.phone, pinyin_initials: @staff.pinyin_initials, remark: @staff.remark, sex: @staff.sex, start_work_time: @staff.start_work_time }
    assert_redirected_to staff_path(assigns(:staff))
  end

  test "should destroy staff" do
    assert_difference('Staff.count', -1) do
      delete :destroy, id: @staff
    end

    assert_redirected_to staffs_path
  end
end
