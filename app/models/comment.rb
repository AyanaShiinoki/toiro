class Comment < ApplicationRecord

	# アソシエーション
	belongs_to :user, optional: true
	belongs_to :exhibition
	# バリデーション
	validates :comment, presence: true


	# 通知機能
	has_many :notifications, dependent: :destroy

end
