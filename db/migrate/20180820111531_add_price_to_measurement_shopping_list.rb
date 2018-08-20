class AddPriceToMeasurementShoppingList < ActiveRecord::Migration[5.2]
  def change
    add_column :measurement_shopping_lists, :price, :float
  end
end
