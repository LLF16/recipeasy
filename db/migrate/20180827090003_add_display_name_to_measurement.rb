class AddDisplayNameToMeasurement < ActiveRecord::Migration[5.2]
  def change
    add_column :measurements, :display_name, :text
  end
end
