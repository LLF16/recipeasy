class SearchesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    if params.present?

      sql_query_1 = "\
      ingredients.name ILIKE :query1 \
      "
      if params["ingredient_1"]
        puts "i'm in the true case"
        query1_value = params["ingredient_1"]
      else
        puts "i'm in the false case"
        query1_value = params["ingredient_1_locked"]
      end


      @recipes_1 = Recipe.joins(:ingredients).where(sql_query_1,
        query1: "#{query1_value}")
      p query1_value

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

      @recipes = @recipes_1 & @recipes_2 & @recipes_3 & @recipes_4

      p @recipes_1.length
      p @recipes_2.length
      p @recipes_3.length
      p @recipes_4.length

      p @recipes.length

      @selected_recipes = []

      if @recipes.length > 2
        # recipe - LEAST TIME
        @recipe_time = @recipes.sort_by{|recipe| recipe[:time]}.first
        @selected_recipes << @recipe_time
        # recipe - MOST CALORIES
        @recipes.delete(@recipe_time)
        @recipe_calories = @recipes.sort_by{|recipe| recipe[:calories]}.last
        @selected_recipes << @recipe_calories
        #recipe - RANDOM
        @recipes.delete(@recipe_calories)
        @selected_recipes << @recipes.shuffle.first
      else
        @selected_recipes = @recipes
      end
    else
      @recipes = Recipe.all
    end

  end
end


# recipe - EASIEST (not needed for the moment)
      # @selected_recipes << @recipes.where("difficulty ILIKE ?", "Easy%").shuffle.first
