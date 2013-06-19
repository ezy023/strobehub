class FavoritesController < ApplicationController

	def create
		p current_user.favorite(version)
		respond_to do |format|
			format.html
			format.js
		end	
	end

end
