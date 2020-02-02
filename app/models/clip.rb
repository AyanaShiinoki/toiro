class Clip < ApplicationRecord

	# アソシエーション
	belongs_to :exhibition
	belongs_to :user

end
