class RemoveDifficultyFromRecipe < ActiveRecord::Migration[5.2]
  def change
    remove_column :recipes, :difficulty, :integer
  end
end
