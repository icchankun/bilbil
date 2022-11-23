class Api::V1::TalkThemesController < ApiController
  before_action :authenticate_admin!, except: [:index]
  before_action :set_talk_theme, only: [:show, :update, :destroy]
  
  # ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    talk_themes = TalkTheme.includes(:likes).all
    render json: talk_themes, each_serializer: TalkThemeSerializer
  end

  def show
    render json: @talk_theme
  end

  def create
    talk_theme =  TalkTheme.new(talk_theme_params)
    if talk_theme.save
      render json: talk_theme
    else
      render json: { errors:  talk_theme.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @talk_theme.update(talk_theme_params)
      head :no_content
    else
      render json: { errors: @talk_theme.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @talk_theme.destroy
    head :no_content
  end

  private
    def set_talk_theme
      @talk_theme = TalkTheme.find(params[:id])
    end

    def talk_theme_params
      params.require(:talk_theme).permit(:content, :category_id)
    end
end
