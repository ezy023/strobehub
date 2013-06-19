class RepositoriesController < ApplicationController
	skip_before_filter :require_login, :only => [:index, :show]

	def new
		@repository = Repository.new
		@tags = Tag.all
	end

	def create
		repository = Repository.new(params[:repository])
		repository.creator_id = current_user.id
		if repository.save
			flash[:success] = "You just created a new repository"
			repository.add_tags(params[:tag])
			version = repository.assign_master_version
			redirect_to repository_version_path(repository, version)
		else
			flash[:error] = "Please make sure to complete all fields"
			redirect_to new_repository_path
		end
	end

	def show
		@repository = Repository.find(params[:id])
		@version = Version.find(@repository.master_version_id)
		tracks = @version.tracks
		@tags = @repository.tags
		respond_to do |format|
			format.html
			format.json { render json: tracks.to_json(:only => [:id, :url, :offset, :duration, :delay]) }
		end
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
