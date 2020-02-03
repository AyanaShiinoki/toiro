class Gallery < ApplicationRecord

	# アソシエーション
	belongs_to :user, optional: true
	has_many :exhibitions


	#バリデーション
	validates :gallery_name, presence: true, length: {maximum: 20}
	validates :concept, length: {maximum: 200}




end
