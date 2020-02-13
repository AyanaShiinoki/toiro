FactoryBot.define do
  factory :exhibition do
  	title {  Faker::Lorem.characters(number:6) }
  	caption { Faker::Lorem.characters(number:30) }
  	is_active { true }
  	user
  end
end
