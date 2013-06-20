 class TracksController < ApplicationController

	def create
      @audio_source = AudioSource.new(:file => params[:song_file])
      if @audio_source.save
        #new_track = Track.new(:url => @audio_source.file.url)
        render :json => @audio_source.file.url
      else
        render :json => "There was an Error"
      end
	end

	def update
		# updates state of track
	end

	def destroy
		# deletes a track
	end
	
end
