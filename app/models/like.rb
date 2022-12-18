class Like < ApplicationRecord
  belongs_to :talk_theme

  # 1つのトークテーマに対して、1つのipアドレスで1つのいいねしかできないようにする。
  validates :talk_theme_id, uniqueness: { scope: :ip }
end
