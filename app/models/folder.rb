class Folder < ApplicationRecord

	# アソシエーション
	belongs_to :user, optional: true
	has_many :clips
	has_many :exhibition, through: :clips

	# #バリデーション
	validates :folder_name, presence: true, length: {maximum: 20}

end
