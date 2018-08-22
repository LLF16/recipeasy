class Ingredient < ApplicationRecord
  belongs_to :ingredient_family

  has_many :measurements
  has_many :recipes, through: :measurements

  enum category: [:base, :topping, :side]

# => Returns all the measurements for the ingredient for the given shopping list
  def measurements_for_shopping_list(shopping_list)
    Measurement.joins([:measurement_shopping_lists, :ingredient]).where("shopping_list_id = ?", shopping_list.id).where(ingredient_id: id)
  end

end

