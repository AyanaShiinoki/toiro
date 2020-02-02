class User < ApplicationRecord

  # アソシエーション
  belongs_to :gallery
  has_many :exhibitions
  has_many :works
  has_many :likes, dependent: :destroy
  has_many :folders
  has_many :comments, dependent: :destroy





  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable,:confirmable
         # :lockable追記
         # 一定回数ログインをミスするとアカウントをロック
         # 時間経過で解除
  #バリデーション
  #devise
  validate :password_complexity
	def password_complexity
  		return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{6,70}$/
  		errors.add :password, "パスワードの強度が不足しています。パスワードの長さは6〜70文字とし、大文字と小文字と数字と特殊文字をそれぞれ1文字以上含める必要があります。"
	end
end
