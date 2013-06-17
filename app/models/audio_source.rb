class AudioSource < ActiveRecord::Base

  attr_accessible :file 

  validates :file,  :presence => true
  
  mount_uploader :file, AudioFileUploader 
end
