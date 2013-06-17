class VersionsController < ApplicationController
	skip_before_filter	:require_login, :only => [:index, :show]

	def index
		@repository = Repository.find(params[:repository_id])
		@versions = @repository.versions
	end

	def new
		@version = Version.new
	end

	def create
		# creates a new version of a repo
	end

	def show
		@repository = Repository.find(params[:repository_id])
		@version = Version.find(params[:id])
	end

	def edit
		@repository = Repository.find(params[:repository_id])
		current_version = Version.find(params[:id])
		if current_version.user == current_user
			@version = current_version
		else
			@version = current_version.clone(current_user)
		end
	end

	def update
		# updates state of the version (tracks added, etc.)
	end

	def destroy
		# deletes the version
	end

end
