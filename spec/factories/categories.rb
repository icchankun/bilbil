FactoryBot.define do
  factory :category do
    name { Faker::Lorem.characters(number:3) }
  end
end
