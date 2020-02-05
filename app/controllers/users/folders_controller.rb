class Users::FoldersController < ApplicationController

	def new
		@folder = Folder.new
	end

	def create
		@folder = Folder.new(folder_params)
		@folder.user_id = current_user.id
		if @folder.save
			redirect_to users_folder_path(@folder)
		end
	end

	def show
		@folder = Folder.find(params[:id])
	end

	def index
	end

	def edit
	end

	def update
	end

	def destroy
	end

	private
	def folder_params
		params.require(:folder).permit(:user_id, :folder_name)
	end


end
