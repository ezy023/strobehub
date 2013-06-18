class Version < ActiveRecord::Base
	attr_accessible :user_id, :repository_id

  has_many   :tracks
  belongs_to :user
  belongs_to :repository

  validates :user_id, :repository_id, :presence => true

  def clone
    new_version = self.dup
    new_version.save
    self.tracks.each do |track|
      new_track = track.dup
      new_version.tracks << new_track
    end
    new_version
  end

  def update_tracks(tracks)
  	tracks.each do |track|
      if track["id"]
  			Track.update(track["id"], :url => track["url"], :delay => track["delay"], :offset => track["offset"], :duration => track["duration"], :track_length => track["trackLength"])
      else
        Track.create(:url => track["url"], :delay => track["delay"], :offset => track["offset"], :duration => track["duration"], :track_length => track["trackLength"], :version_id => self.id)
      end
		end
  end

end
