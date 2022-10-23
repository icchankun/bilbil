class Api::V1::CategoriesController < ApiController
  before_action :authenticate_admin!, except: [:index]
  before_action :set_category, only: [:show, :update, :destroy]

  # ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    categories = Category.preload(:talk_themes).all
    render json: categories, each_serializer: CategorySerializer, include: [ :talk_themes ]
  end

  def show
    render json: @category
  end

  def create
    category =  Category.new(category_params)
    if category.save
      render json:  category, status: :created
    else
      render json: { errors:  category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      head :no_content
    else
      render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    head :no_content
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
