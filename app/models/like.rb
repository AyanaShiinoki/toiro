class Like < ApplicationRecord

	# アソシエーション
	belongs_to :exhibition
	belongs_to :user, optional: true

end
