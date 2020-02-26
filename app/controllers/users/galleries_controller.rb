class Users::GalleriesController < ApplicationController



before_action :authenticate_user!



	def new
		if current_user.gallery == nil
			@gallery = Gallery.new
		else
			redirect_to edit_users_gallery_path(current_user.gallery.id)
		end
	end

	def create
		@gallery = Gallery.new( gallery_params )
		@gallery.user_id = current_user.id
		if @gallery.save
			redirect_to users_user_path(current_user)
		end
	end

	def show
		# @gallery = Gallery.find(params[:id])
		# @user = User.find (@gallery.user.id)
	end

	def index
		@galleries = Gallery.all
	end

	def edit
		@gallery = Gallery.find(params[:id])
		if @gallery.user != current_user
			redirect_to root_path
		end
	end

	def update
		@gallery = Gallery.find(params[:id])
		if @gallery.update(gallery_params)
			redirect_to users_user_path(@gallery.user.id),notice_update: "successfully updated!"
		else
			render 'edit'
		end
	end

	private
	def gallery_params
		params.require(:gallery).permit(:user_id, :gallery_name, :concept)
	end
end
