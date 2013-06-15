class AudioSource < ActiveRecord::Base

  attr_accessible :type, :filename, :title, :data

  validates :type, :filename, :title, :data, :presence => true
  
end
