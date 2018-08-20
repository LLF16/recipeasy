class CreateMeasurementShoppingLists < ActiveRecord::Migration[5.2]
  def change
    create_table :measurement_shopping_lists do |t|
      t.references :shopping_list, foreign_key: true
      t.references :measurement, foreign_key: true

      t.timestamps
    end
  end
end
