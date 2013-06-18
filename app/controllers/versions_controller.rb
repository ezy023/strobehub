class VersionsController < ApplicationController
	skip_before_filter	:require_login, :only => [:index, :show]
	respond_to :json

	def index
		@repository = Repository.find(params[:repository_id])
		@versions = @repository.versions
	end

	def new
		@version = Version.new
	end

	def create
	  version = Version.find(params[:id])
    new_version = version.clone
    current_user.versions << new_version
    repository = Repository.find(params[:repository_id])
    if request.xhr?
			respond_to do |format|
				format.json { render json: {repository_id: repository.id, version_id: new_version.id} }
			end
		else
    	redirect_to repository_version_path(repository, new_version)
		end
  end

	def show
		@repository = Repository.find(params[:repository_id])
		@version = Version.find(params[:id])
		@tracks = @version.tracks.order("id")
		respond_to do |format|
			format.html
			format.json { render json: @tracks.to_json(:only => [:id, :url, :offset, :duration, :delay]) }
		end
	end

	def update
		version = Version.find(params[:id])
		if current_user == version.user
			version.update_tracks(params[:tracks])
			respond_to do |format|
				format.json { render :json => "Saved Succesfully" }
			end
		else
			respond_to do |format|
				format.json { render :json => "NO. You can't do that." }
			end
		end
	end

	def destroy
		# deletes the version
	end

end
