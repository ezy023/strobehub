class VersionsController < ApplicationController
	skip_before_filter	:require_login, :only => [:index, :show]
	
	def index
		# shows all the versions belonging to a repo
	end

	def create
		# creates a new version of a repo
	end

	def show
		# shows the version
	end

	def edit
		# allows version creator to edit the version
	end

	def update
		# updates state of the version (tracks added, etc.)
	end

	def destroy
		# deletes the version
	end

end