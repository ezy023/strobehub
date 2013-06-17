class TracksController < ApplicationController

	def create
    @audio_source = AudioSource.new(:file => params[:song_file])
    if @audio_source.save
      flash[:success] = "File Uploaded"
      @audio_source.file.url
      respond_to do |format|
        format.json { render :json => @audio_source.file.url }
      end
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
