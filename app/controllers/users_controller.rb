 class UsersController < ApplicationController
	skip_before_filter :require_login, :only => [:index, :new, :show]

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			session[:user_id] = @user.id
			flash[:success] = "You have signed up successfully"
			redirect_to user_path(@user)
		else
			flash[:error] = "You had errors in your signup"
			redirect_to new_user_path
		end
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		# in case a user wants to update their info?
	end

	def update
		# updates user info
	end

	def destroy
		# deletes a user account
	end

end
