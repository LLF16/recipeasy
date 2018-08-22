class RemovePriceFromMeasurementShoppingLists < ActiveRecord::Migration[5.2]
  def change
    remove_column :measurement_shopping_lists, :price, :float
  end
end
