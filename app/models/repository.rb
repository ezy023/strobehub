class Repository < ActiveRecord::Base

  attr_accessible :name, :description, :creator_id, :creator, :master_version_id

  has_many :versions
  has_many :users, :through => :versions
  belongs_to :creator, :class_name => "User", :foreign_key => :creator_id
  belongs_to :master_version, :class_name => "Version", :foreign_key => :master_version_id

  validates :name, :description, :creator_id, :presence => true

  def assign_master(version)
  	self.master_version_id = version.id
  	self.save
  end
end
