FactoryBot.define do
  factory :gallery do
  	gallery_name { Faker::Lorem.characters(number:6) }
  	concept { Faker::Lorem.characters(number:20) }
  	user
  end
end