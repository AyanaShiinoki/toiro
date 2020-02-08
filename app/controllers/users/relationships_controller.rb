class Users::RelationshipsController < ApplicationController

	def create
		# @user = User.find(params[:relationship][:follower_id])
		current_user.follow(params[:user_id])
		# 通知(フォローした人が作成)
		@user = User.find(params[:user_id])
		@user.create_notification_follow!(current_user)
		# 通知
		redirect_to request.referer
	end

	def destroy
		current_user.unfollow(params[:user_id])
		redirect_to request.referer
	end

	def follower
		user = User.find(params[:user_id])
		@users = user.following_user
	end

	def followed
		user = User.find(params[:user_id])
		@users = user.follower_user
	end

end
