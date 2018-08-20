class ShoppingList < ApplicationRecord
  belongs_to :user
  has_many :measurement_shopping_lists
  has_many :measurements, through: :measurement_shopping_lists
end
