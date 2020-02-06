class Users::ExhibitionsController < ApplicationController


	def new
		@exhibition = Exhibition.new
		@exhibition.works.build
	end

	def create
		@exhibition = Exhibition.new(exhibition_params)
		@exhibition.user_id = current_user.id
		if @exhibition.save
			redirect_to users_exhibition_path(@exhibition)
		end
	end


	def show
		@exhibition = Exhibition.find(params[:id])
		@works = Work.where(exhibition_id: @exhibition.id)
		@comment = Comment.new
		@clip = Clip.new
		@folders = Folder.where(user_id: current_user.id)
	end

	def index
		@exhibitions = Exhibition.where(is_active: true).all
		@random = @exhibitions.offset(rand( @exhibitions.count)).limit(1)
	end

	def edit
		@exhibition = Exhibition.find(params[:id])
		if @exhibition.user != current_user
			redirect_to users_exhibition_path(@exhibition.id)
		end
	end

	def update
		@exhibition = Exhibition.find(params[:id])
		if @exhibition.update(exhibition_params)
			redirect_to users_exhibition_path(@exhibition.id)
		end
	end

	def random
		exhibitions = Exhibition.where(is_active: true).all
		@random = exhibitions.offset(rand(exhibitions.count)).limit(1)

		@exhibition = Exhibition.find(params[:id])
		@works = Work.where(exhibition_id: @exhibition.id)
		@comment = Comment.new
		@clip = Clip.new
		@folders = Folder.where(user_id: current_user.id)
	end

	private

	def exhibition_params
		params.require(:exhibition).permit(:user_id, :gallery_id, :title , :caption ,:is_active, works_attributes: [:id,:user_id,:exhibition_id,:work_title,:description,:work_image, :_destroy])
	end
end

