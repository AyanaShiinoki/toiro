class Users::ExhibitionsController < ApplicationController

# 未登録でも個展一覧機能と詳細機能は使用可
before_action :authenticate_user!, except: [:index,:show]


	def new
		@exhibition = Exhibition.new
		@exhibition.works.build
	end

	def create
		@exhibition = Exhibition.new(exhibition_params)
		@exhibition.user_id = current_user.id
		if @exhibition.save
			redirect_to users_exhibition_path(@exhibition)
		else
			render 'new'
		end
	end


	def show
		@exhibition = Exhibition.find(params[:id])
		@works = Work.where(exhibition_id: @exhibition.id)
		if user_signed_in?
		@comment = Comment.new
		@clip = Clip.new
		@folders = Folder.where(user_id: current_user.id)
		@comments = @exhibition.comments.order(created_at: :desc).limit(5)
		# @comments = @exhibition.comments.page(params[:page]).reverse_order.per(5)
		end
	end

	def index
		@exhibitions = Exhibition.where(is_active: true).order(created_at: :desc).page(params[:active]).per(10)
		@random = @exhibitions.offset(rand( @exhibitions.count)).limit(1)
	end

	def edit
		@exhibition = Exhibition.find(params[:id])
		if @exhibition.user != current_user
			redirect_to root_path
		end
	end

	def update
		@exhibition = Exhibition.find(params[:id])
		if @exhibition.update(exhibition_params)
			redirect_to users_exhibition_path(@exhibition.id)
		else
			render 'edit'
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

	def destroy
		@exhibition = Exhibition.find(params[:id])
		if @exhibition.user != current_user
			redirect_to users_user_path(current_user)
		end
		@exhibition.destroy
		redirect_to users_user_path(current_user)
	end

	private

	def exhibition_params
		params.require(:exhibition).permit(:user_id, :gallery_id, :title , :caption ,:is_active, works_attributes: [:id,:user_id,:exhibition_id,:work_title,:description,:work_image, :_destroy])
	end
end

