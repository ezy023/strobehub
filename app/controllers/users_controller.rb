class UsersController < ApplicationController
	skip_before_filter :require_login, :only => [:index, :new, :show]

	def index
		#show all the users? something something
	end

	def new
		# form to create an account
	end

	def create
		# creates a new user account
	end

	def show
		@user = User.find(params[:id])
		@user_repos = Repository.where(:creator_id => params[:id])
		@forked_repos = @user.versions.reject {|version| version.repository.creator == @user}.map {|version| version.repository}
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
