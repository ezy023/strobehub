class Version < ActiveRecord::Base
  
  has_many   :tracks
  belongs_to :user
  belongs_to :repository

  validates :user_id, :repository_id, :presence => true  

end
