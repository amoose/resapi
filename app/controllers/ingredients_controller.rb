class IngredientsController < ApplicationController
	before_action :set_ingredient, only: [:show, :edit, :update, :destroy]

	def index
		@ingredients = Ingredient.all
		@recent_ingredients = Ingredient.all.limit(10)
	end


	def new
		@ingredient = Ingredient.new
		@data_source = DataSource.new
		@data_source_types = DataSourceType.all
	end

	private
		def ingredient_params
      params.require(:ingredient).permit(
		    	:name,
		    	:data_source_type => [:id]
        )
    end

    def set_ingredient
    	@ingredient = Ingredient.find(params[:id])
    end
end
