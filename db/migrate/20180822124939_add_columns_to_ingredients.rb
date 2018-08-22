class AddColumnsToIngredients < ActiveRecord::Migration[5.2]
  def change
    add_column :ingredients, :price, :float
    add_column :ingredients, :unit, :string
  end
end
