class Admins::HomeController < ApplicationController

	def top
		@users = User.where("DATE(created_at) = '#{Date.today}'")
		@exhibitions = Exhibition.where("DATE(created_at) = '#{Date.today}'")
	end
end
