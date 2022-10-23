require "test_helper"

class EndUser::HomesControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get end_user_homes_top_url
    assert_response :success
  end
end
