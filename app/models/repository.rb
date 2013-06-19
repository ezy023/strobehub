class Repository < ActiveRecord::Base

  attr_accessible :name, :description, :creator_id, :creator, :master_version_id

  has_many :versions
  has_many :users, :through => :versions
  has_many :repo_tags
  has_many :tags, :through => :repo_tags
  belongs_to :creator, :class_name => "User", :foreign_key => :creator_id
  belongs_to :master_version, :class_name => "Version", :foreign_key => :master_version_id

  validates :name, :description, :creator_id, :presence => true

  def add_tags(tags)
    tags.each { |tag_id| self.tags << Tag.find(tag_id) }
  end

  def assign_master_version
    version = Version.create(:repository_id => self.id, :user_id => self.creator.id)
  	self.master_version_id = version.id
  	self.save
    version
  end
end
