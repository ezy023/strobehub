class Favorite < ActiveRecord::Base
	belongs_to :version
	belongs_to :user
end
