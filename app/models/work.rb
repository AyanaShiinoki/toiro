class Work < ApplicationRecord

	# アソシエーション
	belongs_to :user
	belongs_to :exhibition

end
