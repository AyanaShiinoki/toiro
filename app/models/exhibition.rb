class Exhibition < ApplicationRecord

	# アソシエーション
	belongs_to :user, optional: true
	has_many :works
	has_many :likes
	has_many :comments
	has_many :clips
	has_many :folders, through: :clips
	# 個展開催と同時に作品を公開　削除も同時に
	accepts_nested_attributes_for :works, allow_destroy: true

	# 通知機能
	has_many :notifications, pendent: :destroy

	#バリデーション
	validates :title, presence: true, length: {maximum: 20}
	validates :caption, presence: true, length: {maximum: 100}
	validates :is_active, inclusion: { in: [true, false] }


	# いいね通知メソッド
	def create_notification_like!(current_user)
		temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
		if temp.blank?
			notification = current_user.active_notifications.new(
				exhibition_id: id,
				visited_id: user_id,
				action: 'like'
			)
			# 自分自身のいいねの場合は通知済みにする
			if notifications.visitor_id == current_user.visited_id
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
		save_notification_comment!(current_user, comment_id, visited_id)
	end

	def save_notification_comment!(current_user, comment_id, visited_id)
		notification = current_user.active_notifications.new(
			exhibition_id: id,
			comment_id: comment_id
			visited_id: visited_id
			action: 'comment'
		)
		if notification.visitor_id == notification.visited_id
			notification.checked = true
		end
		notification.save if notification.valid?
	end

	# フォロー通知のメソッド
	def creat_notification_follow!(current_user)
		temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow']
			if temp.blank?
				notification = current_user.active_notifications.new(
					visited_id: id
					action: 'follow'
				)
				notification.save if notification.valid?
			end
	end

end
