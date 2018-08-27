class RemoveDisplayNameFromIngredient < ActiveRecord::Migration[5.2]
  def change
    remove_column :ingredients, :display_name, :text
  end
end
