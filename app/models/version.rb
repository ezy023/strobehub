class Version < ActiveRecord::Base
	attr_accessible :user_id, :repository_id

  has_many   :tracks
  belongs_to :user
  belongs_to :repository

  validates :user_id, :repository_id, :presence => true  

  def self.update_version(tracks, version_id)
    # we need ALL the attributes of the track passed in via the JSON string
  	tracks.each do |track|
			Track.create(:url => track["url"], :delay => track["delay"], :offset => track["offset"], :duration => track["duration"], :track_length => 7.8, :version_id => version_id)
		end
  end

end
