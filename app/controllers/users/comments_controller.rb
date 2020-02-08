class Users::CommentsController < ApplicationController

	def new
		# @exhibition = Exhibition.find(params[:id])
		# @commnet = Comment.new
	end

	def create
		@exhibition = Exhibition.find(params[:exhibition_id])
		@comment = @exhibition.comments.new(comment_params)
		@comment.user_id = current_user.id
		# @comment.exhibition_id = @exhibition.id
		if @comment.save
			# 通知
			@exhibition.create_notification_comment!(current_user, @comment.id)
			# 通知
			redirect_to users_exhibition_path(@exhibition)
		end
	end

	def destroy
		@commnet = Comment.find(params[:exhibition_id])
		if @commnet.user != current_user
			redirect_to request.referer
		end
		@comment.destroy
	end


	private
	def comment_params
		params.require(:comment).permit(:exhibition_id,:user_id,:comment)
	end
end
