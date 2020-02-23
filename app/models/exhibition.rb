class Exhibition < ApplicationRecord

	# アソシエーション
	belongs_to :user, optional: true
	# dependent: :destroyを書かないと個展（親）の物理削除ができない
	has_many :works, dependent: :destroy
	has_many :likes, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :clips, dependent: :destroy
	has_many :folders, through: :clips
	# 個展開催と同時に作品を公開　削除も同時に
	accepts_nested_attributes_for :works, allow_destroy: true

	# 通知機能
	has_many :notifications, dependent: :destroy

	#バリデーション
	validates :title, presence: true, length: {maximum: 20}
	validates :caption, presence: true, length: {maximum: 50}
	validates :is_active, inclusion: { in: [true, false] }



	# いいね判別メソッド
	def liked_by?(user)
		likes.where(user_id: user.id).exists?
	end



	# いいね通知メソッド
	def create_notification_like!(current_user)
		temp = Notification.where(["visitor_id = ? and visited_id = ? and exhibition_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
		if temp.blank?
			notification = current_user.active_notifications.new(
				exhibition_id: id,
				visited_id: user_id,
				action: 'like'
			)
			# 自分自身のいいねの場合は通知済みにする
		      if notification.visitor_id == notification.visited_id
		        notification.checked = true
			end
			notification.save if notification.valid?
		end
	end

	# コメント通知メソッド
	def create_notification_comment!(current_user, comment_id)
		temp_ids = Comment.select(:user_id).where(exhibition_id: id).where.not(user_id: current_user.id).distinct
		temp_ids.each do |temp_id|
			save_notification_comment!(current_user, comment_id, temp_id['user_id'])
		end
		save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
	end

	def save_notification_comment!(current_user, comment_id, visited_id)
		notification = current_user.active_notifications.new(
			exhibition_id: id,
			comment_id: comment_id,
			visited_id: visited_id,
			action: 'comment'
		)
		if notification.visitor_id == notification.visited_id
			notification.checked = true
		end
		notification.save if notification.valid?
	end


end
