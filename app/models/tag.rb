class Tag < ActiveRecord::Base
	attr_accessible	:name
	
	has_many	:repo_tags
	has_many	:repositories, :through => :repo_tags

	validates	:name, :presence => true
end