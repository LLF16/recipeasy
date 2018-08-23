class Recipes::MeasurementsShoppingListController < ApplicationController
  def destroy
    @shopping_list = current_user.shopping_lists.first
    @recipe = Recipe.find(params[:recipe_id])
    if @shopping_list.measurements_for_recipe(@recipe).destroy_all
      redirect_to shopping_list_path(@shopping_list)
    else
    end
  end
end
