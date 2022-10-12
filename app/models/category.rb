class Category < ApplicationRecord
  has_many :talk_themes
  validates :name, presence: true
end
