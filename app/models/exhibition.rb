class Exhibition < ApplicationRecord

	# アソシエーション
	belongs_to :user, optional: true
	has_many :works
	has_many :likes
	has_many :comments
	has_many :clips
	has_many :folders, through: :clips

	#バリデーション
	validates :title, presence: true, length: {maximum: 20}
	validates :caption, presence: true, length: {maximum: 100}
	validates :is_active, inclusion: { in: [true, false] }

end
