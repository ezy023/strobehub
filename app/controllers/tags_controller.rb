class TagsController < ApplicationController
	skip_before_filter	:require_login
	
	def index
		@tags = Tag.all
	end

	def show
		@tag = Tag.find(params[:id])
		@repositories = @tag.repositories
	end
end