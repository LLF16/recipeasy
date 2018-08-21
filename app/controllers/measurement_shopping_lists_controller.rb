class MeasurementShoppingListsController < ApplicationController
before_action :set_sl_measurement

  def destroy
    if @sl_measurement.destroy
      # redirect_to user_shopping_list_path(@user, @shopping_list)
    else
      render :new
    end
  end

  private

  def set_user
    @user = current_user
  end

  def set_shopping_list
    @shopping_list = ShoppingList.find(params[:shopping_list_id])
  end

  def set_sl_measurement
    @sl_measurement = MeasurementShoppingList.find(params[:id])
  end

end
