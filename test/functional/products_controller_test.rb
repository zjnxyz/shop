require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, product: { img_url: @product.img_url, is_percentage: @product.is_percentage, is_rural_areas: @product.is_rural_areas, name: @product.name, number: @product.number, over_royalty_percentage: @product.over_royalty_percentage, percentage_price: @product.percentage_price, pinyin_initials: @product.pinyin_initials, purchase_price: @product.purchase_price, sell_price: @product.sell_price, status: @product.status, stock_lower_limit: @product.stock_lower_limit, stock_quantity: @product.stock_quantity, subsidies_proportion: @product.subsidies_proportion, summary: @product.summary }
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, id: @product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product
    assert_response :success
  end

  test "should update product" do
    put :update, id: @product, product: { img_url: @product.img_url, is_percentage: @product.is_percentage, is_rural_areas: @product.is_rural_areas, name: @product.name, number: @product.number, over_royalty_percentage: @product.over_royalty_percentage, percentage_price: @product.percentage_price, pinyin_initials: @product.pinyin_initials, purchase_price: @product.purchase_price, sell_price: @product.sell_price, status: @product.status, stock_lower_limit: @product.stock_lower_limit, stock_quantity: @product.stock_quantity, subsidies_proportion: @product.subsidies_proportion, summary: @product.summary }
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, id: @product
    end

    assert_redirected_to products_path
  end
end
