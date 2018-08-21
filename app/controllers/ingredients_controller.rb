class IngredientsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    respond_to do |format|
      format.html
      format.json { @ingredients = Ingredient.search(params[:term]) }
    end
  end
end
