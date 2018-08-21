class Recipe < ApplicationRecord
  serialize :steps, Hash

  has_many :measurements
  has_many :ingredients, through: :measurements
  has_many :recipe_beverages
  has_many :beverages, through: :recipe_beverages
  has_many :recipe_users
  has_many :users, through: :recipe_users
end
