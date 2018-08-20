class MeasurementShoppingList < ApplicationRecord
  belongs_to :shopping_list
  belongs_to :measurement
end
