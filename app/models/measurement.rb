class Measurement < ApplicationRecord
  belongs_to :ingredient
  belongs_to :recipe
  has_many :measurement_shopping_lists
  has_many :shopping_lists, through: :measurement_shopping_lists

  def measurement_for(shopping_list)
    measurement_shopping_lists.where(shopping_list_id: shopping_list.id).first
  end
end
