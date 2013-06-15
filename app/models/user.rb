class User < ActiveRecord::Base

  attr_accessible :username, :email, :password, :password_confirmation
  
  has_secure_password

  validates :username, :presence => true, :uniqueness => {:case_sensitive => false}
  validates :email, :presence => true, :uniqueness => {:case_sensitive => false}, :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
  validates :password, :presence => true, :confirmation => true


  has_many :versions
  has_many :repositories, :through => :versions
end
