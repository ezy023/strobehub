class VersionsController < ApplicationController
	skip_before_filter	:require_login, :only => [:index, :show]
	
	def index
		@repository = Repository.find(params[:repository_id])
		@versions = @repository.versions
	end

	def create
		# creates a new version of a repo
	end

	def show
		@repository = Repository.find(params[:repository_id])
		@version = Version.find(params[:id])
	end

	def edit
		@repo_id = params[:repository_id]
		@version_id = params[:id]
	end

	def update
		Version.update_version(params[:tracks], params[:id])
		render 'versions/edit'
	end

	def destroy
		# deletes the version
	end

end