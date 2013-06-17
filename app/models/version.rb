class Version < ActiveRecord::Base
	attr_accessible :user_id, :repository_id

  has_many   :tracks
  belongs_to :user
  belongs_to :repository

  validates :user_id, :repository_id, :presence => true  

  def self.update_version(tracks, version_id)
    puts "hello"
  	tracks.each do |track|
			Track.update(track["id"], :url => track["url"], :delay => track["delay"], :offset => track["offset"], :duration => track["duration"], :track_length => track["trackLength"], :version_id => version_id)
		end
  end

end
