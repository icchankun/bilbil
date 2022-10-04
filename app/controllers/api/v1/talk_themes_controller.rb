class Api::V1::TalkThemesController < ApiController
  before_action :authenticate_admin!
  
  def index
  end
end
