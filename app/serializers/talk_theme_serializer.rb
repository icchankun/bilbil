class TalkThemeSerializer < ActiveModel::Serializer
  attributes :id, :content, :category_id
end
