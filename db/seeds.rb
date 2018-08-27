# NEW SCRAPING SCRIPT

require "open-uri"
require "nokogiri"
require_relative "recipe_urls"

# DELETING EXISTING DATA FROM THE CURRENT DATABASE
puts "Destroy recipe_users"
RecipeUser.destroy_all if Rails.env.development?

puts "Destroy measurement_shopping_lists"
MeasurementShoppingList.destroy_all if Rails.env.development?

puts "Destroy measurements"
Measurement.destroy_all if Rails.env.development?

puts "Destroy recipe_beverages"
RecipeBeverage.destroy_all if Rails.env.development?

puts "Destroy beverages"
Beverage.destroy_all if Rails.env.development?

puts "Destroy beverage_categories"
BeverageCategory.destroy_all if Rails.env.development?

puts "Destroy ingredients"
Ingredient.destroy_all if Rails.env.development?

puts "Destroy shopping_lists"
ShoppingList.destroy_all if Rails.env.development?

puts "Destroy recipe_users"
RecipeUser.destroy_all if Rails.env.development?

puts "Destroy recipes"
Recipe.destroy_all if Rails.env.development?

puts "Destroy users"
User.destroy_all if Rails.env.development?

puts "Resetting IDs"
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

puts "Creating users..."
User.create!([
  {
    last_name: "Gordon",
    vegan: false,
    vegetarian: false,
    email: "gramsey@example.com",
    password: "123456"
  },
  {
    last_name: "Mum",
    vegan: false,
    vegetarian: false,
    email: "mum@example.com",
    password: "123456"
  },
  {
    last_name: "Jamie",
    vegan: false,
    vegetarian: false,
    email: "joliver@example.com",
    password: "123456"
  }
]);
puts "Created #{User.all.length} users"

# testing_urls = [
#   'https://www.kitchenstories.com/en/recipes/mozzarella-stuffed-gnocchi-with-tomato-confit',
#   'https://www.kitchenstories.com/en/recipes/5-ingredient-pasta-with-red-pepper-pesto',
#   'https://www.kitchenstories.com/en/recipes/tagliatelle-with-pancetta-leek-and-tomato',
#   'https://www.kitchenstories.com/en/recipes/spaghetti-in-marinara-sauce',
#   'https://www.kitchenstories.com/en/recipes/insalata-caprese-with-baked-cherry-tomatoes',
# ]

@recipes_urls.each do |url|
  html_file = open(url).read
  doc = Nokogiri::HTML(html_file)

# SCRAPING RECIPES---------------------------------------------------------------
new_recipe = Recipe.new(
{
  name: doc.search('.recipe-title').text.strip,
  photo: doc.search('.recipe-header__image-container img').first.values[1],
  calories: doc.search('.recipe-nutrition .col-1 span')[1].text.strip,
  fat: doc.search('.recipe-nutrition .col-3 span')[1].text.strip,
  carb: doc.search('.recipe-nutrition .col-4 span')[1].text.strip,
  protein: doc.search('.recipe-nutrition .col-2 span')[1].text.strip,
  difficulty: doc.search('.recipe-difficulty span').text,
  time: doc.search('.recipe-time .col-1 div').attr('data-time'),
  serves: serves = doc.search('.stepper-value').text.strip,
  utensils: [],
})

# scraping recipe.utensils
doc.search('.recipe-utensils .comma-separated-list li').each do |utensil|
  new_recipe.utensils << utensil.text.strip
end

# scraping recipe.steps
i = 1
doc.search('.recipe-steps .step p').each do |step|
  new_recipe.steps[i] = step.text.strip
  i += 1
end

new_recipe.save!
# END SCRAPING RECIPES-----------------------------------------------------------

# SCRAPING INGREDIENTS-----------------------------------------------------------
clean_ingredients = %w(mozzarella tomato basil onion garlic potatoes mascarpone parmesan pecorino gorgonzola lasagne tagliatelle spaghetti macaroni penne conchiglie linguine leek pancetta chicken arugula spinach ricotta egg shallot zucchini beef mushrooms prosciutto peas fusilli eggplant broccoli avocado carrots hazelnuts asparagus pinenuts salt thyme)
clean_ingredients << "chili pepper"
clean_ingredients << "bell pepper"
clean_ingredients << "goat cheese"
clean_ingredients << "olive oil"

counter = 0
scraped_ingredients = []
scraped_measurements_unit = []
scraped_measurements_value = []
while counter < doc.search('.ingredients tr').length
  scraped_ingredients << doc.search('.ingredients tr .ingredients__col-2')[counter].text.strip
  scraped_measurements_unit << doc.search('.ingredients tr .ingredients__col-1')[counter].attr('data-unit')
  scraped_measurements_value << doc.search('.ingredients tr .ingredients__col-1')[counter].attr('data-amount')
  counter += 1
end

p scraped_measurements_value
p scraped_measurements_unit

main_ingredients = []
main_measurements_unit = []
main_measurements_value = []
scraped_ingredients.each do |scraped_ingredient|
  scraped_ingredient.downcase!
  clean_ingredients.select do |clean_name|
    if scraped_ingredient.include?(clean_name) || scraped_ingredient.include?(clean_name.pluralize)
      ingredient_found = Ingredient.where(name: clean_name).first
      # ingredient_found.unit = scraped_measurements_unit[scraped_ingredients.index(scraped_ingredient)]
      if ingredient_found
        measurement = Measurement.new
        measurement.ingredient_id = ingredient_found.id
        measurement.recipe_id = new_recipe.id
        measurement.display_name = scraped_ingredient
        measurement.value = scraped_measurements_value[scraped_ingredients.index(scraped_ingredient)]
        measurement.save!
        # p ingredient_found
        # p measurement
        # p "found"
        main_ingredients << scraped_ingredient
        main_measurements_unit << scraped_measurements_unit[scraped_ingredients.index(scraped_ingredient)]
        main_measurements_value << scraped_measurements_value[scraped_ingredients.index(scraped_ingredient)]
      else
        ingredient = Ingredient.new(
          name: clean_name
          )
        ingredient.unit = scraped_measurements_unit[scraped_ingredients.index(scraped_ingredient)]
        ingredient.save!
        measurement = Measurement.new
        measurement.ingredient_id = ingredient.id
        measurement.recipe_id = new_recipe.id
        measurement.display_name =  scraped_ingredient
        measurement.value = scraped_measurements_value[scraped_ingredients.index(scraped_ingredient)]
        measurement.save!
        # p ingredient
        # p measurement
        # p "new clean"
        main_ingredients << scraped_ingredient
        main_measurements_unit << scraped_measurements_unit[scraped_ingredients.index(scraped_ingredient)]
        main_measurements_value << scraped_measurements_value[scraped_ingredients.index(scraped_ingredient)]
      end
    end
  end
end

ingredients_to_be_scraped = scraped_ingredients - main_ingredients
measuremements_to_be_scraped_unit = scraped_measurements_unit - main_measurements_unit
measuremements_to_be_scraped_value = scraped_measurements_value - main_measurements_value

ingredients_to_be_scraped.each do |scraped_ingredient|
  scraped_ingredient.downcase!
  ingredient = Ingredient.where(name: scraped_ingredient).first
  unless ingredient.present?
    ingredient = Ingredient.new(name: scraped_ingredient)
    ingredient.unit = scraped_measurements_unit[scraped_ingredients.index(scraped_ingredient)]
    ingredient.save!
    measurement = Measurement.new
    measurement.ingredient_id = ingredient.id
    measurement.recipe_id = new_recipe.id
    measurement.display_name = scraped_ingredient
    measurement.value = measuremements_to_be_scraped_value[ingredients_to_be_scraped.index(scraped_ingredient)]
    measurement.save!
    # p ingredient
    # p measurement
    # p "new scraped"
  end

end

sleep(1)
end

puts "Creating shopping lists..."
ShoppingList.create!([
  {
    user_id: 1,
    total_price: 100
  },
  {
    user_id: 2,
    total_price: 400
  },
  {
    user_id: 3,
    total_price: 150
  }
]);
puts "Created #{ShoppingList.all.length} shopping lists"


puts "Creating measurement shopping lists..."
MeasurementShoppingList.create!([
  {
    shopping_list_id: 1,
    measurement_id: 1
  },
  {
    shopping_list_id: 1,
    measurement_id: 2
  },
  {
    shopping_list_id: 1,
    measurement_id: 3
  },
  {
    shopping_list_id: 1,
    measurement_id: 4
  },
  {
    shopping_list_id: 1,
    measurement_id: 5
  },
  {
    shopping_list_id: 1,
    measurement_id: 40
  },
  {
    shopping_list_id: 1,
    measurement_id: 42
  },
  {
    shopping_list_id: 1,
    measurement_id: 41
  },
  {
    shopping_list_id: 1,
    measurement_id: 25
  },
  {
    shopping_list_id: 1,
    measurement_id: 33
  },
  # this one has nil value
  # {
  #   shopping_list_id: 1,
  #   measurement_id: 54,
  #   price: 20
  # },
  {
    shopping_list_id: 2,
    measurement_id: 29
  },
  {
    shopping_list_id: 3,
    measurement_id: 25
  }
]);
puts "Created #{MeasurementShoppingList.all.length} measurements shopping lists"
