class TalkThemeSerializer < ActiveModel::Serializer
  attributes :id, :content, :category_id

  has_many :likes, serializer: LikeSerializer
end
