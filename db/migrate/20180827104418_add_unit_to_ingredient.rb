class AddUnitToIngredient < ActiveRecord::Migration[5.2]
  def change
    add_column :ingredients, :unit, :string
  end
end
