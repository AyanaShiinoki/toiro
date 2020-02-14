class Users::ClipsController < ApplicationController



before_action :authenticate_user!

	def create
		exhibition = Exhibition.find(params[:exhibition_id])
		folders = Folder.where(user_id: current_user.id)
		clip = Clip.new(clip_params)
		clip.exhibition_id = exhibition.id
		if clip.save
		redirect_back(fallback_location: root_path)
		end
	end

	def destroy
		# folder = Folder.find(params[:folder_id])
		exhibition = Exhibition.find(params[:exhibition_id])
		clip = Clip.find_by(exhibition_id: exhibition.id)
	    if clip.destroy
	      redirect_back(fallback_location: root_path)
	    end
	end

	private
	def clip_params
		params.require(:clip).permit(:folder_id, :exhibition_id, :memo, :is_active)
	end
end


