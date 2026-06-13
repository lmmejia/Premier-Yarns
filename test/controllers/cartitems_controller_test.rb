require "test_helper"

class CartitemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cartitem = cartitems(:one)
  end

  test "should get index" do
    get cartitems_url
    assert_response :success
  end

  test "should get new" do
    get new_cartitem_url
    assert_response :success
  end

  test "should create cartitem" do
    assert_difference("Cartitem.count") do
      post cartitems_url, params: { cartitem: { cart_id: @cartitem.cart_id, product_id: @cartitem.product_id } }
    end

    assert_redirected_to shopper_url
  end

  test "should show cartitem" do
    get cartitem_url(@cartitem)
    assert_response :success
  end

  test "should get edit" do
    get edit_cartitem_url(@cartitem)
    assert_response :success
  end

  test "should update cartitem" do
    patch cartitem_url(@cartitem), params: { cartitem: { cart_id: @cartitem.cart_id, product_id: @cartitem.product_id } }
    assert_redirected_to cartitem_url(@cartitem)
  end

  test "should destroy cartitem" do
    assert_difference("Cartitem.count", -1) do
      delete cartitem_url(@cartitem)
    end

    assert_redirected_to cartitems_url
  end
end
