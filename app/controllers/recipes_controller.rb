class RecipesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    if params.present?
      sql_query = "\
      ingredients.name ILIKE :query1 AND\
      ingredients.name ILIKE :query2 AND\
      ingredients.name ILIKE :query3 AND\
      ingredients.name ILIKE :query4 \
      "
      @recipes = Recipe.joins(:ingredients).where(sql_query, query1: params["ingredient_1"], query2: params["ingredient_2"],query3: params["ingredient_3"],query4: params["ingredient_4"])
      @selected_recipes = @recipes.take(3)
    else
      @recipes = Recipe.all
    end
  end

  def new
  end


end
