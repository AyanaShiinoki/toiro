class Users::ClipsController < ApplicationController

	def create
		exhibition = Exhibition.find(params[:exhibition_id])
		clip = exhibition.clips.new(clip_params)
		folders = Folder.where(user_id: current_user.id)
		clip.save
		redirect_to users_exhibition_path(exhibition)
	end

	def destroy
		exhibition = Exhibition.find(params[:exhibition_id])
		clip = Clip.find_by(exhibition_id: exhibition.id)
		# @exhibition = Exhibition.find(params[:exhibition_id])
		# clip = current_user.clip.find_by(exhibition_id: @exhibition.id)
		if clip.destroy
		redirect_to root_path
		end
	end

	private
	def clip_params
		params.require(:clip).permit(:folder_id, :exhibition_id, :memo, :is_active)
	end
end


