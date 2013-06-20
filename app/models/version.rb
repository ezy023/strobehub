class Version < ActiveRecord::Base
	attr_accessible :user_id, :repository_id, :parent_version_id

  has_many    :tracks
  has_many    :favorites
  has_many    :user_favorites, :through => :favorites, :source => :user
  belongs_to  :user
  belongs_to  :repository
  belongs_to  :parent_version, :class_name => "Version", :foreign_key => :parent_version_id

  validates :user_id, :repository_id, :presence => true

  def spork(tracks)
    new_version = self.dup
    new_version.parent_version_id = self.id
    new_version.save
    tracks.each do |track|
      Track.create(:url => track["url"], :delay => track["delay"], :offset => track["offset"], :duration => track["duration"], :track_length => track["trackLength"], :version_id => new_version.id)
    end
    new_version
  end

  def update_tracks(tracks)
  	tracks.each do |track|
      if track["id"]
        if track["deleted"] == true
          Track.find(track["id"]).destroy
        else
  			 Track.update(track["id"], :url => track["url"], :delay => track["delay"], :offset => track["offset"], :duration => track["duration"], :track_length => track["trackLength"])
        end
      else
        Track.create(:url => track["url"], :delay => track["delay"], :offset => track["offset"], :duration => track["duration"], :track_length => track["trackLength"], :version_id => self.id)
      end
		end
  end

  def self.from_users_followed_by(user)
    followed_users = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    where("user_id IN (#{followed_users})", user_id: user.id).limit(10).order("updated_at DESC")
  end
     

end
