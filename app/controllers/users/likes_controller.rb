class Users::LikesController < ApplicationController



before_action :authenticate_user!


	def create
		exhibition = Exhibition.find(params[:exhibition_id])
		like = Like.new
		like.user_id = current_user.id
		like.exhibition_id = exhibition.id
		if like.save
		exhibition.create_notification_like!(current_user)
		redirect_back(fallback_location: root_path)
		end

	end

	def destroy
		exhibition = Exhibition.find(params[:exhibition_id])
		like = current_user.likes.find_by(exhibition_id: exhibition.id)
		if like.destroy
		redirect_back(fallback_location: root_path)
		end
	end
end
