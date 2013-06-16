class Version < ActiveRecord::Base
	attr_accessible :user_id, :repository_id

  has_many   :tracks
  belongs_to :user
  belongs_to :repository

  validates :user_id, :repository_id, :presence => true  

end
