class RemoveReference < ActiveRecord::Migration[5.2]
  def change
    remove_reference :ingredients, :ingredient_family, index: true, foreign_key: true
  end
end
