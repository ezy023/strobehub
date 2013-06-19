class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter		:require_login, :get_user
  helper_method   :current_user

  include ApplicationHelper

  def require_login
  	unless current_user
  		flash[:error] = "You must be logged in to do that"
  		redirect_to login_path
  	end
  end

  def current_user
    # use an instance variable to prevenut multiple database calls per request cycle:
    # return @current_user if defined? @current_user
    # @current_user = User.find(session[:user_id]) if session[:user_id]
    User.find(session[:user_id]) if session[:user_id]
  end

  # this method smells, seems redundant / unncessary
  def get_user
    @user = current_user
  end

end
