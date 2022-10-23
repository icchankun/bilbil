require "test_helper"

class Api::V1::CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_categories_index_url
    assert_response :success
  end
end
