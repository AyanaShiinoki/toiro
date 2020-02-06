class User < ApplicationRecord

  # アソシエーション
  belongs_to :gallery, optional: true
  has_many :exhibitions
  has_many :works
  has_many :likes, dependent: :destroy
  has_many :folders
  has_many :comments, dependent: :destroy
  # プロフィール画像機能
  attachment :user_image

  # フォロー機能
  # 自分がフォローしているユーザとの関係
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed

  # 自分をフォローしている人との関係
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :follower_user, through: :followed, source: :follower




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
  # validates :name, presence: true, length: {maximum: 10, minimum: 2}

  # validates :encrypted_password,presence: true
  validates :introduction,length: { maximum: 50 }


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



# パスワードバリデーション
	def password_complexity
  		return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{6,70}$/
  		errors.add :password, "パスワードの強度が不足しています。パスワードの長さは6〜70文字とし、大文字と小文字と数字と特殊文字をそれぞれ1文字以上含める必要があります。"
	end
end
