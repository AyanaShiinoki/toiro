class Folder < ApplicationRecord

	# アソシエーション
	belongs_to :user
	has_many :clips
	has_many :exhibition, through: :clips

end
