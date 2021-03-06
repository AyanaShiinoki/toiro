class Admins::ExhibitionsController < ApplicationController

before_action :authenticate_admin!

	def index
		@exhibitions = Exhibition.all.page(params[:page]).per(10)
	end

	def show
		@exhibition = Exhibition.find(params[:id])
		@works = Work.where(exhibition_id: @exhibition.id)
		@comments = Comment.where(exhibition_id: @exhibition.id)
	end

	def edit
		@exhibition = Exhibition.find(params[:id])
	end

	def update
		@exhibition = Exhibition.find(params[:id])
		if @exhibition.update(exhibition_params)
			redirect_to admins_exhibition_path(@exhibition.id)
		end
	end

	def destroy
		@exhibition = Exhibition.find(params[:id])
		@exhibition.destroy
		redirect_to admins_user_path(@exhibition.user)
	end

	private

	def exhibition_params
		params.require(:exhibition).permit(:user_id, :gallery_id, :title , :caption ,:is_active, works_attributes: [:id,:user_id,:exhibition_id,:work_title,:description,:work_image, :_destroy])
	end

end
