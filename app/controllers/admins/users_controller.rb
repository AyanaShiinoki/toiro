class Admins::UsersController < ApplicationController

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
		@folders = Folder.where(user_id: @user.id)
		@exhibitions = Exhibition.where(user_id: @user.id)
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
			if@user.update(user_params)
			redirect_to admins_user_path(@user.id)
			else
			render 'edit'
			end
	end


	private
	def user_params
		params.require(:user).permit(:name,:user_image,:introduction)
	end
end
