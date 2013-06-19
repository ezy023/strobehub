 class UsersController < ApplicationController
	skip_before_filter :require_login, :only => [:index, :new, :show, :create]

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
		@user_repos = @user.created_repositories
		@sporked_repos = @user.versions.reject {|version| version.repository.creator == @user}.map {|version| version.repository}.uniq
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

  def following
    @user = User.find_by_id(params[:id])
    @followed_users = @user.followed_users.all
  end

  def followers
    @user = User.find_by_id(params[:id])
    @followers = @user.followers.all
  end

end
