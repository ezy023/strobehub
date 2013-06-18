class Track < ActiveRecord::Base

  attr_accessible :url, :delay, :offset, :duration, :volume, :track_length, :version_id, :version
  belongs_to :version

  validates :url, :delay, :offset, :duration, :volume, :track_length, :version_id, :presence => true

  def clone(version=nil)
    self_attr = self.attributes
    self_attr.delete('created_at')
    self_attr.delete('updated_at')
    self_attr.delete('id')
    self_attr['version'] = version
    Track.new(self_attr)
  end
end
