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
	end

	def index
		
	end

	def edit
		
	end

	def update
		
	end

	private

	def exhibition_params
		params.require(:exhibition).permit(:user_id, :gallery_id, :title , :caption ,:is_active, works_attributes: [:id,:user_id,:exhibition_id,:work_title,:description,:work_image, :_destroy])
	end
end

