class TracksController < ApplicationController

	def create
    @audio_source = AudioSource.new(:file => params[:file])
    if @audio_source.save
      flash[:success] = "File Uploaded"
      render "versions/edit"
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
