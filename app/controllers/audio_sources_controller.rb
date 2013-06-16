class AudioSourcesController < ApplicationController
  
  def new 
    @audio_source = AudioSource.new
  end

  def create
    @audio_source = AudioSource.create(params[:audio])
  end

  def destroy
  end
end
