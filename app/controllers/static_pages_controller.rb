class StaticPagesController < ApplicationController
	skip_before_filter :require_login

	def index
		@repositories = Repository.all.sort_by do |repo|
			-repo.versions.count
		end[0..4]

		@users = User.all.sort_by do |user|
			-user.versions.count
		end[0..4]
	end

	def new
	end

end
