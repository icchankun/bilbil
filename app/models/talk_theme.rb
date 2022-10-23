class TalkTheme < ApplicationRecord
  belongs_to :category
  has_many :likes, dependent: :destroy
  validates :content, presence: true
end
