class ShoppingList < ApplicationRecord
  belongs_to :user
  has_many :measurement_shopping_lists
  has_many :measurements, through: :measurement_shopping_lists
  has_many :ingredients, -> { distinct }, through: :measurements

  def total_price
    sum = 0
    ingredients.each do |ingredient|
      sum += ingredient.total_price_in_shopping_list(self)
    end
    sum
  end

  def recipes
    Recipe.joins(measurements: :measurement_shopping_lists).distinct.where("measurement_shopping_lists.shopping_list_id = ?", id)
  end

  def measurements_for_recipe(a_recipe)
    MeasurementShoppingList.joins(:measurement).where("measurements.recipe_id = ?", a_recipe.id)
  end

  def has_recipe(a_recipe)
    recipes.include?(a_recipe)
  end

end
