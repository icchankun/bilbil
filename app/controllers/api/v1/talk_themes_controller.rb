class Api::V1::TalkThemesController < ApiController
  before_action :authenticate_admin!
  
  # ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    talk_themes = TalkTheme.all
    render json: talk_themes, each_serializer: TalkThemeSerializer
  end

  def create
    talk_theme =  TalkTheme.new(talk_theme_params)
    if talk_theme.save
      render json:  talk_theme, status: :created
    else
      render json: { errors:  talk_theme.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
    def talk_theme_params
      params.require(:talk_theme).permit(:content, :category_id)
    end
end
