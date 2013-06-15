class Track < ActiveRecord::Base

  attr_accessible :url, :delay, :offset, :duration, :volume, :track_length

  belongs_to :version
  
end
