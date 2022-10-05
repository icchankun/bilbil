class Api::V1::TalkThemesController < ApiController
  before_action :authenticate_admin!
  
  # ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    talk_themes = TalkTheme.all
    render json: talk_themes
  end
end
