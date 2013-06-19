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

    	# you dont need this:
			# respond_to do |format|
			# 	format.json { render json: {repository_id: repository.id, version_id: new_version.id} }
			# end

			# we can just do this:
			render json: {repository_id: repository.id, version_id: new_version.id}
		else
    	redirect_to repository_version_path(repository, new_version)
		end
  end

	def show
		@repository = Repository.find(params[:repository_id])
		@version = Version.find(params[:id])
		@tracks = @version.tracks.order("id") # itd be nice to be explicit about whether its "id ASC" or "id DESC"
		@tags = @repository.tags
		respond_to do |format|
			format.html
			format.json { render json: @tracks.to_json(:only => [:id, :url, :offset, :duration, :delay]) }
		end
	end

	def update
		version = Version.find(params[:id])
		if current_user == version.user
			version.update_tracks(params[:tracks])

			# if we know this action only handles ajax requests, we dont need to be using respond_to
			# respond_to do |format|
			# 	format.json { render :json => "Saved Succesfully" }
			# end

			render :json => "Saved Succesfully"
		else
			# respond_to do |format|
			# 	format.json { render :json => "NO. You can't do that." }
			# end

			render :json => "NO. You can't do that."
		end
	end

	def destroy
		# deletes the version
	end

	def history
		@repository = Repository.find(params[:repository_id])
		@version = Version.find(params[:id])
		@parents = Version.where(:repository_id => @repository.id) - [@version]
		@parents.reverse!
	end

end
