class Version < ActiveRecord::Base
  
  has_many :tracks
  belongs_to :user
  belongs_to :repository

end
