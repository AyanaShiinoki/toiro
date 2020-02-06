class Users::ClipsController < ApplicationController

	def create
		exhibition = Exhibition.find(params[:exhibition_id])
		clip = exhibition.clips.new(clip_params)
		folders = Folder.where(user_id: current_user.id)
		clip.save
		redirect_to users_exhibition_path(exhibition)
	end

	def destroy
	    @clip = Clip.find(params[:id])
	    if @clip.destroy
	      redirect_to users_folder_path(current_user)
	    end
	end

	private
	def clip_params
		params.require(:clip).permit(:folder_id, :exhibition_id, :memo, :is_active)
	end
end


