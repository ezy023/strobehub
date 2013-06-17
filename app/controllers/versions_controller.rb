class VersionsController < ApplicationController
	skip_before_filter	:require_login, :only => [:index, :show]
	respond_to :json
	
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
		@tracks = @version.tracks
	end

	def edit
		@repository = Repository.find(params[:repository_id])
		@version = Version.find(params[:id])
		@tracks = @version.tracks
		respond_to do |format|
			format.html
			format.json { render json: @tracks.to_json(:only => [:id, :url]) }
		end
	end

	def update
		Version.update_version(params[:tracks], params[:id])
		render 'versions/edit'
	end

	def destroy
		# deletes the version
	end

end