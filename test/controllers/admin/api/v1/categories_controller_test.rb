require "test_helper"

class Admin::Api::V1::CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_api_v1_categories_index_url
    assert_response :success
  end
end
