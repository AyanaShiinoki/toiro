class Admins::ExhibitionsController < ApplicationController

	def index
		@exhibitions = Exhibition.all
	end

	def show
		@exhibition = Exhibition.find(params[:id])
		@works = Work.where(exhibition_id: @exhibition.id)
		@comments = Comment.where(exhibition_id: @exhibition.id).page(params[:page]).reverse_order.per(5)
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
