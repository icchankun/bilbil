class Api::V1::CategoriesController < ApiController
  before_action :authenticate_admin!

  # ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    categories = Category.all
    render json: categories, each_serializer: CategorySerializer
  end

  def create
    category =  Category.new(category_params)
    if category.save
      render json:  category, status: :created
    else
      render json: { errors:  category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
    def category_params
      params.require(:category).permit(:name)
    end
end
