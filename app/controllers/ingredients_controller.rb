class IngredientsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @ingredients = Ingredient.all
  end


end
