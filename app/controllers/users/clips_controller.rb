class Users::ClipsController < ApplicationController

	def create
		exhibition = Exhibition.find(params[:exhibition_id])
		clip = exhibition.clips.new(clip_params)
		folders = Folder.where(user_id: current_user.id)
		clip.save
		redirect_to users_exhibition_path(exhibition)
	end

	def destroy
		end
	end

	private
	def clip_params
		params.require(:clip).permit(:folder_id, :exhibition_id, :memo, :is_active)
	end
end


