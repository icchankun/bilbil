class Admin::TalkThemesController < ApiController
  before_action :authenticate_admin!
  
  def index
  end
end
