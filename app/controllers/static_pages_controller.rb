class StaticPagesController < ApplicationController
	skip_before_filter :require_login

	def index
		@repositories = Repository.all.sort_by do |repo|
			-repo.versions.count
		end[0..4]

		@users = User.all.sort_by do |user|
			-user.followers.count
		end[0..4]

		@versions = Version.all.sort_by do |version|
			-version.user_favorites.count
		end[0..4]

	end

	def new
	end

end
