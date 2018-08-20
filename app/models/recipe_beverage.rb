class RecipeBeverage < ApplicationRecord
  belongs_to :beverage
  belongs_to :recipe
end
