class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable
         # :lockable追記
         # 一定回数ログインをミスするとアカウントをロック
         # 時間経過で解除
end
