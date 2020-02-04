class Clip < ApplicationRecord

	# アソシエーション
	belongs_to :exhibition
	belongs_to :user, optional: true

	# #バリデーション
	# validates :is_active, inclusion: { in: [true, false] }

end
