class ShoppingLists::RecipesController < ApplicationController
  def destroy
    @shopping_list = ShoppingList.find(params[:shopping_list_id])
    @recipe = Recipe.find(params[:id])
    # fech shopping from params
    # fetch recipe from params
    # destroy all measurment shopping list for specific recipe
    if @shopping_list.measurements_for_recipe(@recipe).destroy_all
      redirect_to shopping_list_path(@shopping_list)
    else
      render :new
    end
  end
end
