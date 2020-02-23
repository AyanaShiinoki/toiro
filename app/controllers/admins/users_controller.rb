class Admins::UsersController < ApplicationController

before_action :authenticate_admin!

	def index
		@users = User.all.with_deleted.page(params[:page]).per(10)
	end

	def show
		@user = User.with_deleted.find(params[:id])
		@exhibitions = Exhibition.where(user_id: @user.id)
	end

	def edit
		@user = User.with_deleted.find(params[:id])
	end

	def update
		@user = User.with_deleted.find(params[:id])

		if params[:user][:deleted_at] == "true"
			@user.restore
			@user.update(user_params)
		else
			@user.destroy
			@user.update(user_params)
		end
		redirect_to admins_user_path(@user.id)

	end


	private
	def user_params
		params.require(:user).permit(:name,:user_image,:introduction)
	end
end
