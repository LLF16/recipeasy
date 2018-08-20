class CreateBeverages < ActiveRecord::Migration[5.2]
  def change
    create_table :beverages do |t|
      t.references :beverage_category, foreign_key: true
      t.string :name
      t.integer :vintage
      t.text :description
      t.boolean :alcohol

      t.timestamps
    end
  end
end
