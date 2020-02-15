FactoryBot.define do

  factory :exhibition do
  	title {  Faker::Lorem.characters(number:6) }
  	caption { Faker::Lorem.characters(number:30) }
  	is_active { true }
  	user
  end

  # factory :exhibition_with_work, class: Exhibition do
  # 	work_title { Faker::Lorem.characters(number:10) }
  # 	description { Faker::Lorem.characters(number:50) }

  # 	after( :create ) do |exhibition|
  #   create :work, exhibition: exhibition
  #   end

  # end



end
