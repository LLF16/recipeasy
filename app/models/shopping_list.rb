class ShoppingList < ApplicationRecord
  belongs_to :user
  has_many :measurement_shopping_lists
  has_many :measurements, through: :measurement_shopping_lists

  def full_price
    price_sum = 0
    self.measurement_shopping_lists.each do |measurement|
      price_sum += measurement.price
    end
    price_sum
  end

# D: Summing the quantity of one ingredient across recipe
#    Assuming the unit of measure is normalized in the db
#    -> one ingredient has always the same unit of measure
#    across recipes.
  def total_quantities(ingredients)
    totals = Hash.new(0)
    self.measurements.each do |measurement|
      totals[measurement.ingredient_id] += measurement.value
    end
    totals_with_names = totals.map do |k, v|
      {ingredients.find(k).name => v}
    end
    totals_with_names
  end

  # def sql_total_quantities
  #   m = Ingredient.joins(:measurements).where('ingredient_id = 1')
  # end

  def recipes
    recipes_array = []
    self.measurements.each do |measurement|
      recipes_array << measurement.recipe.name
    end
    recipes_array.uniq
  end

end
