class Users::HomeController < ApplicationController

	def top
		exhibition = Exhibition.where(is_active: true).all
		@exhibitions = exhibition.offset(rand(exhibition.count)).limit(3)
	end

	def about
		
	end
end
