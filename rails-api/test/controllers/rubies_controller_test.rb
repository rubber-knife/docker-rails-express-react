require 'test_helper'

class RubiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ruby = rubies(:one)
  end

  test "should get index" do
    get rubies_url, as: :json
    assert_response :success
  end

  test "should create ruby" do
    assert_difference('Ruby.count') do
      post rubies_url, params: { ruby: { name: @ruby.name, price: @ruby.price } }, as: :json
    end

    assert_response 201
  end

  test "should show ruby" do
    get ruby_url(@ruby), as: :json
    assert_response :success
  end

  test "should update ruby" do
    patch ruby_url(@ruby), params: { ruby: { name: @ruby.name, price: @ruby.price } }, as: :json
    assert_response 200
  end

  test "should destroy ruby" do
    assert_difference('Ruby.count', -1) do
      delete ruby_url(@ruby), as: :json
    end

    assert_response 204
  end
end
