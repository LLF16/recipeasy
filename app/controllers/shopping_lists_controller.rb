class ShoppingListsController < ApplicationController
  def show
    @user = current_user
    @shopping_list = @user.shopping_list
    @ingredients = Ingredient.all
  end

  def send_email
    if UserMailer.welcome(current_user.id).deliver_now
      flash[:notice] = "Email sent!"
      redirect_to shopping_list_path(current_user.shopping_list)
    else
      flash[:alert] = "Oops, something went wrong :("
      redirect_to shopping_list_path(@shopping_list)
    end
  end
end

