class Ingredient < ApplicationRecord

  has_many :measurements
  has_many :recipes, through: :measurements

  mount_uploader :photo, PhotoUploader

  enum category: [:base, :topping, :side]

# => Returns all the measurements for the ingredient for the given shopping list
  def measurements_for_shopping_list(shopping_list)
    Measurement.joins([:measurement_shopping_lists, :ingredient]).where("shopping_list_id = ?", shopping_list.id).where(ingredient_id: id)
  end

  def total_amount_in_shopping_list(shopping_list)
     Measurement.joins([:measurement_shopping_lists, :ingredient]).where("shopping_list_id = ?", shopping_list.id).where(ingredient_id: id).sum(:value)
  end

  def relatives
    Measurement.joins(:ingredient).where("ingredient_id = ?", id)
  end

   def relatives_in_shopping_list(shopping_list)
    Measurement.joins(:ingredient, :measurement_shopping_lists).where("ingredient_id = ?", id).where("shopping_list_id = ?", shopping_list.id)
  end

  class << self
    def ingredient_names
      %w(mozzarella chili\spepper bell\spepper olive\soil goat\scheese tomatoes basil onions garlic potatoes mascarpone parmesan pecorino gorgonzola lasagne tagliatelle spaghetti macaroni penne conchiglie linguine leek pancetta chicken arugula spinach ricotta egg shallot zucchini beef mushrooms prosciutto peas fusilli eggplant broccoli avocado carrots hazelnuts asparagus pinenuts salt thyme)
    end

    def clean_ingredients
      ingredient_names.map do |ingredient|
        Ingredient.where(name: ingredient).first
      end.compact
    end
  end

  # def total_price_in_shopping_list(shopping_list)
  #   self.price * self.total_amount_in_shopping_list(shopping_list)
  # end

  # def total_price_for_measurement(measurement)
  # measurement.value
  # end

end

