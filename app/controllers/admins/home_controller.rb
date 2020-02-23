class Admins::HomeController < ApplicationController

	def top
		@users = User.where("DATE(created_at) = '#{Date.today}'").page(params[:users]).per(6)
		@exhibitions = Exhibition.where("DATE(created_at) = '#{Date.today}'").page(params[:exhibitions]).per(6)
	end
end
