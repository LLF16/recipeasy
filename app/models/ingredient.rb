class Ingredient < ApplicationRecord
  belongs_to :ingredient_family

  has_many :measurements
  has_many :recipes, through: :measurements

  enum category: [:base, :topping, :side]

  def.self.search(term)
    Ingredient.where('name ILIKE ?',"%#{term.downcase}%")
  end

end
