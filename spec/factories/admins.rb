FactoryBot.define do
  factory :admin do
  	email { Faker::Internet.email }
  	password { 'admins' }
  	password_confirmation { 'admins' }
  end
end
