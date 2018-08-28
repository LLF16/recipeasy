class IngredientsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    # get_four_random
    @ingredients = Ingredient.clean_ingredients
  end

  private

#   def get_four_random
#     @ingredients_to_send = Array.new
#     @ingredient_1 = Ingredient.clean_ingredients.shuffle.first
#     @ingredient_1_select = Ingredient.clean_ingredients
#     @recipes_with_ingredient_1 = @ingredient_1.recipes
#     @ingredients_to_send << @ingredient_1

#     @sample_ingredient_2 = Array.new
#     @recipes_with_ingredient_1.each do |recipe|
#       recipe.ingredients.each do |ingredient|
#         if ingredient != @ingredient_1
#           @sample_ingredient_2 << ingredient
#         end
#       end
#     end
#     @new_sample_ingredient_2 = @sample_ingredient_2.select do |sample_ingredient|
#       Ingredient.ingredient_names.include?(sample_ingredient.name)
#     end
#     # @new_sample_ingredient_2
#     @ingredient_2 = @new_sample_ingredient_2.shuffle.first
#     @ingredients_to_send << @ingredient_2

#     @recipes_with_ingredient_2 = @ingredient_2.recipes

#     @recipes_with_ingredient_1_2 = @recipes_with_ingredient_2 & @recipes_with_ingredient_1

#     @sample_ingredient_3 = Array.new
#     @recipes_with_ingredient_1_2.each do |recipe|
#       recipe.ingredients.each do |ingredient|
#         if ingredient != @ingredient_1 && ingredient != @ingredient_2
#           @sample_ingredient_3 << ingredient
#         end
#       end
#     end
#     @new_sample_ingredient_3 = @sample_ingredient_3.select do |sample_ingredient|
#       Ingredient.ingredient_names.include?(sample_ingredient.name)
#     end
#     # @new_sample_ingredient_3
#     @ingredient_3 = @new_sample_ingredient_3.shuffle.first
#     @ingredients_to_send << @ingredient_3

#     @recipes_with_ingredient_3 = @ingredient_3.recipes

#     @recipes_with_ingredient_1_2_3 = @recipes_with_ingredient_1 & @recipes_with_ingredient_2 & @recipes_with_ingredient_3


#     @sample_ingredient_4 = Array.new
#     @recipes_with_ingredient_1_2_3.each do |recipe|
#       recipe.ingredients.each do |ingredient|
#         if ingredient != @ingredient_1 && ingredient != @ingredient_2 && ingredient != @ingredient_3
#           @sample_ingredient_4 << ingredient
#         end
#       end
#     end
#     @new_sample_ingredient_4 = @sample_ingredient_4.select do |sample_ingredient|
#       Ingredient.ingredient_names.include?(sample_ingredient.name)
#     end
#     # @new_sample_ingredient_4
#     @ingredient_4 = @new_sample_ingredient_4.shuffle.first
#     @ingredients_to_send << @ingredient_4
#     return @ingredients_to_send
#   end
 end
