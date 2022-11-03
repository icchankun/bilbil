class Api::V1::LikesController < ApiController
  before_action :set_like, only: [:judge, :destroy]

  # ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def show
    likes = Like.where(talk_theme_id: params[:talk_theme_id])
    render json: likes, each_serializer: LikeSerializer
  end

  def judge
    render json: @like
  end

  def ip
    likes = Like.where(ip: request.remote_ip)
    render json: likes, each_serializer: LikeSerializer
  end

  def create
    like = Like.create(ip: request.remote_ip, talk_theme_id: params[:talk_theme_id])
    like.save
    head :created
  end

  def destroy
    @like.destroy
    head :no_content
  end

  private

  def set_like
    @like = Like.find_by(ip: request.remote_ip, talk_theme_id: params[:talk_theme_id])
  end
end
