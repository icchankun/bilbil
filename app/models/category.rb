class Category < ApplicationRecord
  has_many :talk_themes
  validates :name, presence: true, length: { in: 2..4 }, uniqueness: true
end
