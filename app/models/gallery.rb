class Gallery < ApplicationRecord

	# アソシエーション
	belongs_to :user
	has_many :exhibitions


end
