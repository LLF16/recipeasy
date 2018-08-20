class CreateRecipeBeverages < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_beverages do |t|
      t.references :beverage, foreign_key: true
      t.references :recipe, foreign_key: true

      t.timestamps
    end
  end
end
