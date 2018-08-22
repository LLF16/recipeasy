class ShoppingList < ApplicationRecord
  belongs_to :user
  has_many :measurement_shopping_lists
  has_many :measurements, through: :measurement_shopping_lists
  has_many :ingredients, -> { distinct }, through: :measurements
  def total_amount
    price_sum = 0
    self.ingredients.each do |ingredient|
      ingredient.measurements_for_shopping_list(self).sum(value)
    end
  end

# D: Summing the quantity of one ingredient across recipe
#    Assuming the unit of measure is normalized in the db
#    -> one ingredient has always the same unit of measure
#    across recipes.
  # def total_quantities(ingredients)
  #   totals = Hash.new(0)
  #   self.measurements.each do |measurement|
  #     if measurement.value
  #       totals[measurement.ingredient_id] += measurement.value
  #     else
  #       totals = ""
  #     end
  #   end
  #   totals_with_names = totals.map do |k, v|
  #     {ingredients.find(k).name => v}
  #   end
  #   totals_with_names
  # end

  def recipes
    Recipe.joins(measurements: :measurement_shopping_lists).distinct.where("measurement_shopping_lists.shopping_list_id = ?", id)
  end

end
