class HomeController < ApplicationController

	def index
		@recent_ingredients = Ingredient.limit(10)
		@ingredient = Ingredient.new
	end

	def search
		
	end

	def create
		@ingredient = Ingredient.new(permitted_params)
	end

	private
		def permitted_params
			params.permit(:name)
		end
end
