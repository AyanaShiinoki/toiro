class Comment < ApplicationRecord

	# アソシエーション
	belongs_to :user, optional: true
	belongs_to :exhibition
	# バリデーション
	validates :comment, presence: true

end
