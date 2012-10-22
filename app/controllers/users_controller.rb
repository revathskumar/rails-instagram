class UsersController < ApplicationController
	skip_before_filter :require_authentication, :index

	def index
		
	end

	def dashboard
		
	end
end
