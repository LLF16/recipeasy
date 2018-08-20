class Beverage < ApplicationRecord
  belongs_to :beverage_category
  has_many :recipe_beverages
  has_many :recipes, through: :recipe_beverages

  validates :name, presence: true
end
