class MeasurementShoppingListsController < ApplicationController
before_action :set_user, :set_shopping_list, :set_sl_measurement

  def destroy
    if @sl_measurement.destroy
      redirect_to

  end

  private

  def set_user
    @user = current_user
  end

  def set_shopping_list
    @shipping_list = ShoppingList.find(params[:shopping_list_id])
  end

  def set_sl_measurement
    @sl_measurement = ShoppingListMeasurement.find(params[:id])
  end

end
