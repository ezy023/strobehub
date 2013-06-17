class Track < ActiveRecord::Base

  attr_accessible :url, :delay, :offset, :duration, :volume, :track_length, :version_id

  belongs_to :version

  validates :url, :delay, :offset, :duration, :volume, :track_length, :version_id, :presence => true

end
