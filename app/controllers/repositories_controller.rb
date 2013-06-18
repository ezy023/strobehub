class RepositoriesController < ApplicationController
	skip_before_filter :require_login, :only => :index

	def index
		#show all repos
	end

	def new
		@repository = Repository.new
	end

	def create
		@repository = Repository.new(params[:repository])
		@repository.creator_id = current_user.id
		if @repository.save
			flash[:success] = "You just created a new repository"
			version = Version.create(:repository_id => @repository.id, :user_id => current_user.id)
			redirect_to repository_version_path(@repository, version)
		else
			flash[:error] = "Please make sure to complete all fields"
			redirect_to new_repository_path
		end
	end

	def show
		redirect_to repository_versions_path(Repository.find(params[:id]))
	end

	def edit

	end

	def update
		# updates a repo (new versions added, merges, etc.)
	end

	def destroy
		# delete a repo
	end

end
