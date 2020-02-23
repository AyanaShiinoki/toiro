class Gallery < ApplicationRecord

	# アソシエーション
	belongs_to :user, optional: true
	has_many :exhibitions, dependent: :destroy


	#バリデーション
	validates :gallery_name, presence: true, length: {maximum: 10}
	validates :concept, presence: true, length: {maximum: 100}





end
