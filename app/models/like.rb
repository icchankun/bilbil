class Like < ApplicationRecord
  belongs_to :talk_theme
  validates :talk_theme_id, uniqueness: { scope: :ip }
end
