class Favorite < ActiveRecord::Base
		
	attr_accessible :version_id, :user_id


	belongs_to :version
	belongs_to :user


end
