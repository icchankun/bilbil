class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :talk_themes
end
