class SearchesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    if params.present?
      p params

      sql_query_1 = "\
      ingredients.name ILIKE :query1 \
      "
      @recipes_1 = Recipe.joins(:ingredients).where(sql_query_1,
        query1: params["ingredient_1"])
      p @recipes_1.class

      sql_query_2 = "\
      ingredients.name ILIKE :query2 \
      "
      @recipes_2 = Recipe.joins(:ingredients).where(sql_query_2,
        query2: params["ingredient_2"])

      sql_query_3 = "\
      ingredients.name ILIKE :query3 \
      "
      @recipes_3 = Recipe.joins(:ingredients).where(sql_query_3,
        query3: params["ingredient_3"])

      sql_query_4 = "\
      ingredients.name ILIKE :query4 \
      "
      @recipes_4 = Recipe.joins(:ingredients).where(sql_query_4,
        query4: params["ingredient_4"])

      p @recipes = @recipes_1 & @recipes_2 & @recipes_3 & @recipes_4

      p @recipes.length

      @selected_recipes = []
      #recipe - RANDOM
      p @selected_recipes << @recipes.shuffle.first
      # recipe - LEAST TIME
      @selected_recipes << @recipes.sort_by{|recipe| recipe[:time]}.first
      # recipe - MOST CALORIES
      @selected_recipes << @recipes.sort_by{|recipe| recipe[:calories]}.first
    else
      @recipes = Recipe.all
    end

  end
end


# recipe - EASIEST (not needed for the moment)
      # @selected_recipes << @recipes.where("difficulty ILIKE ?", "Easy%").shuffle.first
