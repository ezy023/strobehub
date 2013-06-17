class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter		:require_login
  helper_method   :current_user

  def require_login
  	unless current_user
  		flash[:error] = "You must be logged in to do that"
  		# redirect_to login_path
  	end
  end

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

end
