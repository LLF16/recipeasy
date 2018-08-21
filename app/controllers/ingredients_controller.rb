class IngredientsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    respond_to do |format|
      format.html
      format.json { @ingredients = Ingredient.search(params[:term]) }
    end
    @random_ingredients = Ingredient.all.sample(4)
  end
end
