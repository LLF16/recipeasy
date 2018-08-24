class ShoppingLists::MeasurementShoppingListsController < ApplicationController

  def create
    @shopping_list = ShoppingList.find(params[:shopping_list_id])
    @recipe = Recipe.find(params[:recipe_id])

    if @shopping_list.recipes.include?(@recipe)
      flash[:notice] = "You already have this recipe in your shopping list!"
    end

    @recipe.measurements.each do |measurement|
      new_measurement = MeasurementShoppingList.new(
        shopping_list_id: @shopping_list.id,
        measurement_id: measurement.id
        )
      new_measurement.save

    end
    redirect_to recipe_path(@recipe)
  end

end