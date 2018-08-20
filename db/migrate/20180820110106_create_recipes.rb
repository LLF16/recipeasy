class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.text :steps
      t.string :name
      t.string :photo
      t.integer :calories
      t.integer :difficulty
      t.integer :serves
      t.string :time
      t.text :description

      t.timestamps
    end
  end
end
