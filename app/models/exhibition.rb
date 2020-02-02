class Exhibition < ApplicationRecord

	# アソシエーション
	belongs_to :user
	has_many :works
	has_many :likes
	has_many :comments
	has_many :clips
	has_many :folders, through: :clips

end
