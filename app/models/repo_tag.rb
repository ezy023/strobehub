class RepoTag < ActiveRecord::Base
	attr_accessible	:repository_id, :tag_id
	
	belongs_to	:repository
	belongs_to	:tag

	validates	:repository, :tag, :presence => true
end