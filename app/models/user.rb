class User < ActiveRecord::Base

  attr_accessible :username, :email, :password, :password_confirmation

  has_secure_password

  validates :username, :presence => true, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true, :uniqueness => { :case_sensitive => false }, :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
  validates :password, :presence => true, :confirmation => true

  has_many :versions
  has_many :repositories, :through => :versions

  has_many :favorites
  has_many :favorite_versions, :through => :favorites, :source => :version

  has_many :created_repositories, :class_name => "Repository", :foreign_key => :creator_id
  has_many :relationships, :foreign_key => "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, :foreign_key => "followed_id", :class_name => "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower


  def favorite(version_found)
  	self.favorites.create(:version_id => version_found.id)
	end

  def following?(other_user)
    self.relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    self.relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    self.relationships.find_by_followed_id(other_user.id).destroy
  end
end
