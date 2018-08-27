class RemoveUnitFromIngredient < ActiveRecord::Migration[5.2]
  def change
    remove_column :ingredients, :unit, :string
  end
end
