class User < ApplicationRecord

  # アソシエーション
  has_one :gallery, dependent: :destroy
  has_many :exhibitions, dependent: :destroy
  has_many :works, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :folders, dependent: :destroy
  has_many :comments, dependent: :destroy
  # プロフィール画像機能
  attachment :user_image
  # 論理削除
  acts_as_paranoid

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable
         # :confirmable
         # :lockable追記
         # 一定回数ログインをミスするとアカウントをロック
         # 時間経過で解除

  #バリデーション
  validate :password_complexity #パスワード強度
  validates :name, presence: true, length: {maximum: 20, minimum: 2}
  validates :email, presence: true,uniqueness: true

  # validates :encrypted_password,presence: true
  validates :introduction,length: { maximum: 150 }

  # フォロー機能
  # 自分がフォローしているユーザとの関係
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed

  # 自分をフォローしている人との関係
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :follower_user, through: :followed, source: :follower

  # 通知機能
  # 自分からの通知
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  # 相手からの通知
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  

  # フォロー機能
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # フォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrue
  def following?(user)
    following_user.include?(user)
  end

  # フォロー通知のメソッド
  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
      if temp.blank?
        notification = current_user.active_notifications.new(
          visited_id: id,
          action: 'follow'
        )
        notification.save if notification.valid?
      end
  end

# パスワードバリデーション
	def password_complexity
  		return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{6,70}$/
  		errors.add :password, "パスワードの強度が不足しています。パスワードの長さは6〜70文字とし、大文字と小文字と数字と特殊文字をそれぞれ1文字以上含める必要があります。"
	end
end
