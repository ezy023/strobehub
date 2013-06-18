class StaticPagesController < ApplicationController
	skip_before_filter :require_login

	def index
		@repositories = Repository.all.sort_by do |repo|
			-repo.versions.count
		end[0..4]

		@users = User.all.sort_by do |user|
			-user.versions.count
		end[0..4]
	end

	def new
	end

	def login
		user = User.find_by_username(params[:static_pages][:username])
		if user && user.authenticate(params[:static_pages][:password])
			session[:user_id] = user.id
			flash[:success] = "You successfully logged in"
			redirect_to user_path(user)
		else
			flash[:error] = "Unsuccessful login attempt"
			render login_path
		end
	end

	def logout
		session.clear
		flash[:success] = "You successfully logged out"
		redirect_to :root
	end

end
