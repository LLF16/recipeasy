class ShoppingListsController < ApplicationController
  def show
    @user = current_user
    @shopping_list = @user.shopping_lists.first
    @ingredients = Ingredient.all
  end
end