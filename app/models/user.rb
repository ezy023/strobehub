class  User < ActiveRecord::Base
  
  attr_accessible :username, :email, :password, :password_confirmation

  validate_uniqueness_of :username, :case_sensitive => false
  validate_uniqueness_of :email, :case_sensitive => false
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  has_secure_password

  validates_confirmation_of :password

  has_many :versions
end
