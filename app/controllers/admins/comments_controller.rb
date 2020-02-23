class Admins::CommentsController < ApplicationController

before_action :authenticate_admin!


	def destroy
		exhibition = Exhibition.find(params[:exhibition_id])
		comment = exhibition.comments.find(params[:id])
		if comment.destroy
		redirect_to request.referer
		end
	end




end
