class User < ActiveRecord::Base

  attr_accessible :username, :email, :password, :password_confirmation

  has_secure_password

  validates :username, :presence => true, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true, :uniqueness => { :case_sensitive => false }, :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
  validates :password, :presence => true, :confirmation => true

  has_many :versions
  has_many :repositories, :through => :versions

  has_many :favorites
  has_many :favorite_versions, :through => :favorites, :class_name => "Version"

  has_many :created_repositories, :class_name => "Repository", :foreign_key => :creator_id

  def favorite(version_found)
  	self.favorites.create(:version_id => version_found.id)
	end

end
