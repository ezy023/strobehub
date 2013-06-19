class TracksController < ApplicationController

	def create
    @audio_source = AudioSource.new(:file => params[:song_file])
    if @audio_source.save
      flash[:success] = "File Uploaded"
      @audio_source.file.url
      # i don't understand why we are initializing a track object only
      # to return the url in this action...
      new_track = Track.new(:url => @audio_source.file.url)
      respond_to do |format|
        format.json { render :json => new_track.url } # why cant we just return @audo_source.file.url ?
      end
    else
      flash[:error] = "No good" # is this an AJAX action? because this isn't a useful response to an xmlhttp request
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
