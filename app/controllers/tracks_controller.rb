class TracksController < ApplicationController

	def create
		repository = Repository.find(params[:repository_id])
		version = Version.find(params[:version_id])
    audio_source = AudioSource.new(:file => params[:file])
    if audio_source.save
      flash[:success] = "File Uploaded"
      Track.create(:url => audio_source.file.url, :version_id => version.id)
      redirect_to edit_repository_version_path(repository, version)
    else
      flash[:error] = "No good"
      redirect_to :back
    end
	end

	def update
		# updates state of track
	end

	def destroy
		# deletes a track
	end
	
end
