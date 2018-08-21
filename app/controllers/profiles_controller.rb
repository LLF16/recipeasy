class ProfilesController < ApplicationController
  def show
    @user = current_user
    @recipes = @user.recipes
  end
end
