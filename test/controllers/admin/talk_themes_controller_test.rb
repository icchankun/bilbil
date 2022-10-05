require "test_helper"

class Admin::TalkThemesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_talk_themes_index_url
    assert_response :success
  end
end
