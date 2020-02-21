class Users::CommentsController < ApplicationController



before_action :authenticate_user!

	def new
		# @exhibition = Exhibition.find(params[:id])
		# @commnet = Comment.new
	end

	def create
		# 非同期の場合は＠をつける
		@exhibition = Exhibition.find(params[:exhibition_id])
		@comment = @exhibition.comments.new(comment_params)
		@comment.user_id = current_user.id
		# @comment.exhibition_id = @exhibition.id
		if @comment.save
			# 通知
			@exhibition.create_notification_comment!(current_user, @comment.id)
			# redirect_to users_exhibition_path(@exhibition)
		end
		@comments = @exhibition.comments.reverse
	end

	def destroy
		# 非同期の場合は＠をつける
		@exhibition = Exhibition.find(params[:exhibition_id])
		@comment = @exhibition.comments.find(params[:id])
		if @comment.user != current_user
		redirect_to request.referer
		end
		@comment.destroy
		@comments = @exhibition.comments.reverse
	end


	private
	def comment_params
		params.require(:comment).permit(:exhibition_id,:user_id,:comment)
	end
end
