class Work < ApplicationRecord

	# アソシエーション
	belongs_to :user, optional: true
	belongs_to :exhibition, optional: true
	# 作品画像投稿機能
	attachment :work_image



	#バリデーション
	validates :work_title, presence: true, length: {maximum: 20}
	validates :description, length: {maximum: 100}

end
