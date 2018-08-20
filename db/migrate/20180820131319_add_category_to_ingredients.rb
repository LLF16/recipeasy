class AddCategoryToIngredients < ActiveRecord::Migration[5.2]
  def change
    add_column :ingredients, :base, :boolean
    add_column :ingredients, :topping, :boolean
    add_column :ingredients, :seasoning, :boolean
  end
end
