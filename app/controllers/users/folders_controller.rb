class Users::FoldersController < ApplicationController



before_action :authenticate_user!


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
		@clips = Clip.where(folder_id: @folder.id)
	end

	def index
		@user = User.find(params[:user_id])
		if params[:user_id]
		@folders = Folder.where(user_id: params[:user_id]).page(params[:page]).per(6)
		elsif @user == current_user
		@folders = Folder.where(user_id: current_user.id).page(params[:page]).per(6)
		end

	end

	def edit
		@folder = Folder.find(params[:id])
		if @folder.user != current_user
			redirect_to root_path
		end
	end

	def update
		@folder = Folder.find(params[:id])
		if @folder.update(folder_params)
			redirect_to users_folder_path(@folder)
		else
			render 'edit'
		end
	end

	def destroy
	end

	private
	def folder_params
		params.require(:folder).permit(:user_id, :folder_name)
	end


end
