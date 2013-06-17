class RepositoriesController < ApplicationController
	skip_before_filter :require_login, :only => :index

	def index
		#show all repos
	end

	def new
		@repository = Repository.new
	end

	def create
		@repository = Repository.new(params[:repository], :creator_id => current_user.id)
		if @repository.save
			flash[:success] = "You just created a new repository"
			redirect_to repository_versions_path(@repository)
		else
			flash[:error] = "Please make sure to complete all fields"
		end
	end

	def show
		redirect_to repository_versions_path(Repository.find(params[:id]))
	end

	def edit
		# change repo description or something 
	end

	def update
		# updates a repo (new versions added, merges, etc.)
	end

	def destroy
		# delete a repo
	end

end