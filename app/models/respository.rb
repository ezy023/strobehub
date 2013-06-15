class Repository < ActiveRecord::Base

  attr_accessible :name, :description

  has_many :versions
  
end
