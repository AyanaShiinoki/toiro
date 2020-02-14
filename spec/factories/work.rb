FactoryBot.define do
  factory :work do
  	work_title { Faker::Lorem.characters(number:10) }
  	description { Faker::Lorem.characters(number:50) }
  	exhibition nil
  	user
  end
end
