class Api::V1::BaseController < ApplicationController
	def index
		if params[:ingredient]

		elsif params[:action] and !params[:ingredient].nil?
			# HOW TO DO THIS?!
		else
			@ingredients = Ingredient.all.limit(10)
			render :json => @ingredients
		end
	end
end
