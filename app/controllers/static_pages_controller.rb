class StaticPagesController < ApplicationController
	skip_before_filter :require_login

	def index
		#home page
	end

	def login
		# forms to log in or create a new account
		# sets session user_id
	end

	def logout
		# clears session user_id
		# redirects to home
	end
end