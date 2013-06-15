class  User < ActiveRecord::Base

  attr_accessible :username, :email, :password, :password_confirmation

  validates_uniqueness_of :username, :case_sensitive => false
  validates_uniqueness_of :email, :case_sensitive => false

  validates_presence_of :username, :email, :password
  validates :email, :presence => true, :uniqueness => true, :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}

  has_secure_password

  validates_confirmation_of :password

  has_many :versions
  has_many :repositories, :through => :versions
end
