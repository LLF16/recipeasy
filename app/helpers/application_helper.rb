module ApplicationHelper
  def default_url_options
    { host: ENV["HOST"] || "www.recipeasy.de" }
  end
end
