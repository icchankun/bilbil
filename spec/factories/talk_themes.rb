FactoryBot.define do
  factory :talk_theme do
    category_id { "1" }
    content { Faker::Lorem.characters(number:5) }
  end
end
