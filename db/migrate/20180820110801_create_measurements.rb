class CreateMeasurements < ActiveRecord::Migration[5.2]
  def change
    create_table :measurements do |t|
      t.references :ingredient, foreign_key: true
      t.references :recipe, foreign_key: true
      t.string :unit
      t.float :value

      t.timestamps
    end
  end
end
