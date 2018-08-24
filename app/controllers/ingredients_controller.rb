class IngredientsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    get_four_random
  end

  private

   def get_four_random
    @ingredients_to_send = Array.new
    @ingredient_1 = Ingredient.all.sample(1).first
    @recipes_with_ingredient_1 = @ingredient_1.recipes
    @ingredients_to_send << @ingredient_1

    @sample_ingredient_2 = Array.new
    @recipes_with_ingredient_1.each do |recipe|
      recipe.ingredients.each do |ingredient|
        if ingredient != @ingredient_1
          @sample_ingredient_2 << ingredient
        end
      end
    end
    @ingredient_2 = @sample_ingredient_2.shuffle.first
    @ingredients_to_send << @ingredient_2

    @recipes_with_ingredient_2 = @ingredient_2.recipes

    @recipes_with_ingredient_1_2 = @recipes_with_ingredient_2 & @recipes_with_ingredient_1

    @sample_ingredient_3 = Array.new
    @recipes_with_ingredient_1_2.each do |recipe|
      recipe.ingredients.each do |ingredient|
        if ingredient != @ingredient_1 && ingredient != @ingredient_2
          @sample_ingredient_3 << ingredient
        end
      end
    end
    @ingredient_3 = @sample_ingredient_3.shuffle.first
    @ingredients_to_send << @ingredient_3

    @recipes_with_ingredient_3 = @ingredient_3.recipes

    @recipes_with_ingredient_1_2_3 = @recipes_with_ingredient_1 & @recipes_with_ingredient_2 & @recipes_with_ingredient_3


    @sample_ingredient_4 = Array.new
    @recipes_with_ingredient_1_2_3.each do |recipe|
      recipe.ingredients.each do |ingredient|
        if ingredient != @ingredient_1 && ingredient != @ingredient_2 && ingredient != @ingredient_3
          @sample_ingredient_4 << ingredient
        end
      end
    end
    @ingredient_4 = @sample_ingredient_4.shuffle.first
    @ingredients_to_send << @ingredient_4
    return @ingredients_to_send
  end

end
