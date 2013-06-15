class  User < ActiveRecord::Base

  attr_accessible :username, :email, :password, :password_confirmation
  
  has_secure_password

  validates :username, :presence => true, :uniqueness => true, :case_sensitive => false
  validates :email, :presence => true, :uniqueness => true, :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}, :case_sensitive => false
  validates :password, :presence => true, :confirmation => true,


  has_many :versions
  has_many :repositories, :through => :versions
end
