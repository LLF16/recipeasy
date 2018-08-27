class RemoveUnitFromMeasurement < ActiveRecord::Migration[5.2]
  def change
    remove_column :measurements, :unit, :string
  end
end
