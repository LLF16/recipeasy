class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.references :ingredient_family, foreign_key: true
      t.string :name
      t.string :photo
      t.boolean :vegan
      t.boolean :vegetarian

      t.timestamps
    end
  end
end
