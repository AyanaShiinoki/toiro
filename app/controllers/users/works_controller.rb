class Users::WorksController < ApplicationController

	def new
		@work = Work.new
	end

	def create
		@work = Work.new( work_params )
		@work.user_id = current_user.id
		if @work.save
			redirect_to users_work_path(@work)
		end
	end

	def show
		@work = Work.find(params[:id])
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
	def work_params
		params.require(:work).permit(:user_id,:exhibition_id,:title,:description,:work_image_id)
	end
end
