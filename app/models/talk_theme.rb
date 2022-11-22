class TalkTheme < ApplicationRecord
  belongs_to :category
  has_many :likes, dependent: :destroy
  validates :content, presence: true, length: { in: 4..30 }, uniqueness: true
end
