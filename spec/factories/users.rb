FactoryBot.define do
  factory :user do
  	name { Faker::Lorem.characters(number:6) }
  	introduction { Faker::Lorem.characters(number:20) }
  	email { Faker::Internet.email }
  	password { 'Pass-43' }
  	password_confirmation { 'Pass-43' }
  end
end