class AddUnitToMeasurement < ActiveRecord::Migration[5.2]
  def change
    add_column :measurements, :unit, :string
  end
end
