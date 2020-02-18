class ApplicationController < ActionController::Base

	# devise利用の機能（ユーザ登録、ログイン認証など）が使われる場合、その前にconfigure_permitted_parametersが実行される。
	before_action :configure_permitted_parameters, if: :devise_controller?

	def after_sign_in_path_for(resource)
		case resource
		when Admin
		admins_root_path
		when User
		root_path
		end
	end

	def after_sign_up_path_for(resource) 
   		 new_users_gallery_path(resource)
  	end

	def after_sign_out_path_for(resource_or_scope)
    	if resource_or_scope == :admin
      	new_admin_session_path
    	else
      	root_path
    	end
  end


	protected
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
	end

end
