class IngredientsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    respond_to do |format|
      format.html
      format.json { @ingredients = Ingredient.search(params[:term]) }
    end
  end

  def self.search(term)
    Ingredient.where('name ILIKE ?',"%#{params[:ingredient_1]}%")
  end

end
