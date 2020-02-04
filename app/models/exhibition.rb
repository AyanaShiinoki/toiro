class Exhibition < ApplicationRecord

	# アソシエーション
	belongs_to :user, optional: true
	has_many :works
	has_many :likes
	has_many :comments
	has_many :clips
	has_many :folders, through: :clips
	# 個展開催と同時に作品を公開　削除も同時に
	# accepts_attachments_for :works, attachment: :work_image
	accepts_nested_attributes_for :works, allow_destroy: true

	#バリデーション
	validates :title, presence: true, length: {maximum: 20}
	validates :caption, presence: true, length: {maximum: 100}
	validates :is_active, inclusion: { in: [true, false] }

end
