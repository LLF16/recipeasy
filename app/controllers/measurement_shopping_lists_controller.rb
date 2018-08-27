class MeasurementShoppingListsController < ApplicationController
before_action :set_sl_measurement

  def destroy
    @shopping_list = @sl_measurement.shopping_list
    if @sl_measurement.destroy
      redirect_to shopping_list_path(@shopping_list), notice: "You removed #{@sl_measurement.measurement.display_name.capitalize} from #{@sl_measurement.measurement.recipe.name}"
    else
      render :new
    end
  end

  private

  def set_sl_measurement
    @sl_measurement = MeasurementShoppingList.find(params[:id])
  end

end
