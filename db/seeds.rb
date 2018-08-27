# NEW SCRAPING SCRIPT

require "open-uri"
require "nokogiri"

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

puts "Destroy ingredient_families"
IngredientFamily.destroy_all if Rails.env.development?

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

testing_urls = [
  'https://www.kitchenstories.com/en/recipes/mozzarella-stuffed-gnocchi-with-tomato-confit',
  'https://www.kitchenstories.com/en/recipes/5-ingredient-pasta-with-red-pepper-pesto',
  'https://www.kitchenstories.com/en/recipes/tagliatelle-with-pancetta-leek-and-tomato',
  'https://www.kitchenstories.com/en/recipes/spaghetti-in-marinara-sauce',
  'https://www.kitchenstories.com/en/recipes/insalata-caprese-with-baked-cherry-tomatoes',
]

testing_urls.each do |url|
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
clean_ingredients = %w(mozzarella tomato basil onion garlic potatoes mascarpone parmesan pecorino gorgonzola lasagne tagliatelle spaghetti macaroni penne conchiglie linguine leek pancetta chicken arugula spinach ricotta egg shallot chilli zucchini beef mushrooms prosciutto peas fusilli eggplant broccoli avocado carrots hazelnuts honey asparagus goatcheese bellpeppers pinenuts )


counter = 0
scraped_ingredients = []
scraped_measurements = []
while counter < doc.search('.ingredients tr').length
  scraped_ingredients << doc.search('.ingredients tr .ingredients__col-2')[counter].text.strip
  scraped_measurements << doc.search('.ingredients tr .ingredients__col-1')[counter].text.strip
  counter += 1
end

p scraped_measurements

main_ingredients = []
main_measurements = []
scraped_ingredients.each do |scraped_ingredient|
  clean_ingredients.select do |clean_name|
    if scraped_ingredient.include?(clean_name) || scraped_ingredient.include?(clean_name.pluralize)
      ingredient_found = Ingredient.where(name: clean_name).first
      if ingredient_found
        ingredient_found.display_name[new_recipe.id] = scraped_ingredient
        measurement = Measurement.new
        measurement.ingredient_id = ingredient_found.id
        measurement.recipe_id = new_recipe.id
        measurement.value = scraped_measurements[scraped_ingredients.index(scraped_ingredient)]
        measurement.save!
        # p measurement
        # p "found"
        # p ingredient_found
        main_ingredients << scraped_ingredient
        main_measurements << scraped_measurements[scraped_ingredients.index(scraped_ingredient)]
      else
        ingredient = Ingredient.new(
          name: clean_name
          )
        ingredient.display_name[new_recipe.id] =  scraped_ingredient
        ingredient.save!
        measurement = Measurement.new
        measurement.ingredient_id = ingredient.id
        measurement.recipe_id = new_recipe.id
        measurement.value = scraped_measurements[scraped_ingredients.index(scraped_ingredient)]
        measurement.save!
        p measurement
        # p "new clean"
        # p ingredient
        main_ingredients << scraped_ingredient
        main_measurements << scraped_measurements[scraped_ingredients.index(scraped_ingredient)]
      end
    end
  end
end

ingredients_to_be_scraped = scraped_ingredients - main_ingredients
measuremements_to_be_scraped = scraped_measurements - main_measurements

ingredients_to_be_scraped.each do |scraped_ingredient|
  ingredient = Ingredient.where(name: scraped_ingredient).first
  unless ingredient.present?
    ingredient = Ingredient.create!(name: scraped_ingredient)
    measurement = Measurement.new
    measurement.ingredient_id = ingredient.id
    measurement.recipe_id = new_recipe.id
    measurement.value = measuremements_to_be_scraped[ingredients_to_be_scraped.index(scraped_ingredient)]
    measurement.save!
    p measurement
    # p "new scraped"
    # p ingredient
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
    measurement_id: 86
  },
  {
    shopping_list_id: 1,
    measurement_id: 80
  },
  {
    shopping_list_id: 1,
    measurement_id: 81
  },
  {
    shopping_list_id: 1,
    measurement_id: 84
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
    measurement_id: 2
  },
  {
    shopping_list_id: 3,
    measurement_id: 2
  }
]);
puts "Created #{MeasurementShoppingList.all.length} measurements shopping lists"
