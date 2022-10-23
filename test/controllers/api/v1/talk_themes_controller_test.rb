require "test_helper"

class Api::V1::TalkThemesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_talk_themes_index_url
    assert_response :success
  end
end
