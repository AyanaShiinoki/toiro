class Users::NotificationsController < ApplicationController


before_action :authenticate_user!


	def index
		@notifications = current_user.passive_notifications.order('id ASC').limit(10)
		@notifications.where(checked: false).each do |notification|
			notification.update_attributes(checked: true)
		end
	end
end
