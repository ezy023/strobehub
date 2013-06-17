class Version < ActiveRecord::Base
	attr_accessible :user_id, :repository_id

  has_many   :tracks
  belongs_to :user
  belongs_to :repository

  validates :user_id, :repository_id, :presence => true

  def clone(user)
    new_version = Version.new
    new_version.repository = repository
    new_version.user = user
    self.tracks.each { |track| track.clone(new_version).save }
    new_version.save
    new_version
  end

end
