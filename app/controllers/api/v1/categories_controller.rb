class Api::V1::CategoriesController < ApiController
  # indexアクション以外はログインによるアクセス制限を行う。
  before_action :authenticate_admin!, except: [:index]

  before_action :set_category, only: [:show, :update, :destroy]

  # ActiveRecordのレコードが見つからなければ404 not foundを応答する。
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    # preloadでtalk_themesとlikesのデータを予め取得しておく。
    categories = Category.preload(talk_themes: :likes)
    render json: categories, each_serializer: CategorySerializer, include: [talk_themes: :likes]
  end

  def show
    render json: @category
  end

  def create
    category =  Category.new(category_params)
    if category.save
      render json: category
    else
      render json: { errors:  category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      render json: @category
    else
      render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    head :no_content
  end

  private
    # @categoryは再使用できるので、メソッドにしておく。
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
