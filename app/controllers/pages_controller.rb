class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  layout 'homepage'

  def home
  end
end
