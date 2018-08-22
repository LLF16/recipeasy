class IngredientsController < ApplicationController
  skip_before_action :authenticate_user!

  def index


    get_first_set_ingredients
    get_second_set_ingredients
    get_third_set_ingredients
    get_fourth_set_ingredients

    @ingredient_4 = @sample_ingredient_4.flatten.sample(1).first
    @recipes_with_ingredient_4 = @ingredient_4.recipes
    @recipes_with_ingredient_1_2_3_4 = @recipes_with_ingredient_1_2_3 & @recipes_with_ingredient_4

    respond_to do |format|
      format.html
      format.json { @ingredients = Ingredient.search(params[:term]) }
    end
    
    @random_ingredients = Ingredient.all.sample(4)
    @selected_recipes

    if params.present?
      sql_query = "\
      ingredients.name ILIKE :query1 OR\
      ingredients.name ILIKE :query2 OR\
      ingredients.name ILIKE :query3 OR\
      ingredients.name ILIKE :query4 \
      "
      @recipes = Recipe.joins(:ingredients).where(sql_query,
        query1: params["ingredient_1"],
        query2: params["ingredient_2"],
        query3: params["ingredient_3"],
        query4: params["ingredient_4"])
      @selected_recipes = @recipes.take(3)
    else
      @recipes = Recipe.all
    end



  end

  private

  def get_first_set_ingredients
    @ingredients_all = Ingredient.all
  end


  def get_second_set_ingredients
    @ingredient_1 = Ingredient.where(name: 'Dried Chorizo').first  #REMOVE .FIRST WHEN SEED ARE FIXED (NO MULTIPLE ID FOR SAME INGREDIENT)

    @recipes_with_ingredient_1 = @ingredient_1.recipes

    @sample_ingredient_2 = Array.new
    @recipes_with_ingredient_1.each do |recipe|
      @sample_ingredient_2 << recipe.ingredients
    end
  end

  def get_third_set_ingredients
    @ingredient_2 = @sample_ingredient_2.flatten.sample(1).first

    @recipes_with_ingredient_2 = @ingredient_2.recipes

    @recipes_with_ingredient_1_2 = @recipes_with_ingredient_2 & @recipes_with_ingredient_1

    @sample_ingredient_3 = Array.new
    @recipes_with_ingredient_1_2.each do |recipe|
      @sample_ingredient_3 << recipe.ingredients
    end
  end

  def get_fourth_set_ingredients
    @ingredient_3 = @sample_ingredient_3.flatten.sample(1).first

    @recipes_with_ingredient_3 = @ingredient_3.recipes

    @recipes_with_ingredient_1_2_3 = @recipes_with_ingredient_1_2 & @recipes_with_ingredient_3

    @sample_ingredient_4 = Array.new
    @recipes_with_ingredient_1_2_3.each do |recipe|
      @sample_ingredient_4 << recipe.ingredients
    end
  end
end
