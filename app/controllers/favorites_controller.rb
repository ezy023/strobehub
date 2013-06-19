class FavoritesController < ApplicationController

	def create
		version = Version.find(params[:version_id])
		current_user.favorite(version)
		respond_to do |format|
			format.html
			format.js 
		end	
	end

end
