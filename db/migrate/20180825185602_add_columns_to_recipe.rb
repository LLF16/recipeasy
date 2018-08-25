class AddColumnsToRecipe < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :carb, :integer
    add_column :recipes, :fat, :integer
    add_column :recipes, :protein, :integer
    add_column :recipes, :utensils, :text
  end
end
