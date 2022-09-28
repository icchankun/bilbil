class Api::V1::CategoriesController < ApiController
  before_action :authenticate_admin!

  # ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    categories = Category.all
    render json: categories
  end
end
