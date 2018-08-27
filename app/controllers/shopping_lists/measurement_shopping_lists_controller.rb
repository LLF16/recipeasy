class ShoppingLists::MeasurementShoppingListsController < ApplicationController

  def create
    @shopping_list = current_user.shopping_lists.first
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

    if @recipe.measurements.all?(&:persisted?)
      respond_to do |format|
        format.html { redirect_to recipe_path(@recipe) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render 'recipes/show'}
        format.js
      end
    end
  end
end
