# require "open-uri"
# require "nokogiri"

# # DELETING EXISTING DATA FROM THE CURRENT DATABASE
# puts "Destroy recipe_users"
# RecipeUser.destroy_all if Rails.env.development?

# puts "Destroy measurement_shopping_lists"
# MeasurementShoppingList.destroy_all if Rails.env.development?

# puts "Destroy measurements"
# Measurement.destroy_all if Rails.env.development?

# puts "Destroy recipe_beverages"
# RecipeBeverage.destroy_all if Rails.env.development?

# puts "Destroy beverages"
# Beverage.destroy_all if Rails.env.development?

# puts "Destroy beverage_categories"
# BeverageCategory.destroy_all if Rails.env.development?

# puts "Destroy ingredients"
# Ingredient.destroy_all if Rails.env.development?

# puts "Destroy ingredient_families"
# IngredientFamily.destroy_all if Rails.env.development?

# puts "Destroy shopping_lists"
# ShoppingList.destroy_all if Rails.env.development?

# puts "Destroy recipe_users"
# RecipeUser.destroy_all if Rails.env.development?

# puts "Destroy recipes"
# Recipe.destroy_all if Rails.env.development?

# puts "Destroy users"
# User.destroy_all if Rails.env.development?

# puts "Resetting IDs"
# ActiveRecord::Base.connection.tables.each do |t|
#   ActiveRecord::Base.connection.reset_pk_sequence!(t)
# end

# # RESETTING EVERY ID TO 0
# # puts “Resetting ids”
# # ActiveRecord::Base.connection.tables.each do |t|
# #  ActiveRecord::Base.connection.reset_pk_sequence!(t)
# # end



# # CREATING NEW DATA
# puts "Creating users..."
# User.create!([
#   {
#     last_name: "Gordon",
#     vegan: false,
#     vegetarian: false,
#     email: "gramsey@example.com",
#     password: "123456"
#   },
#   {
#     last_name: "Mum",
#     vegan: false,
#     vegetarian: false,
#     email: "mum@example.com",
#     password: "123456"
#   },
#   {
#     last_name: "Jamie",
#     vegan: false,
#     vegetarian: false,
#     email: "joliver@example.com",
#     password: "123456"
#   }
# ]);
# puts "Created #{User.all.length} users"

# puts "Creating ingredient families..."
# IngredientFamily.create!([
#   {
#     name: "cheese",
#   },
#   {
#     name: "herbs",
#   },
#   {
#     name: "meat",
#   },
#   {
#     name: "vegetables",
#   },
#   {
#     name: "pasta",
#   }
# ]);
# puts "Created #{IngredientFamily.all.length} recipes"

# # SETTING UP SCRAPER URL
# urls =[
#   'https://www.hellofresh.com/recipes/chorizo-burgers-5b63796530006c374433cce2?locale=en-US',
#   'https://www.hellofresh.com/recipes/quick-beef-ragu-spaghetti-5abd4797ae08b549e56a1502?locale=en-US',
#   'https://www.hellofresh.com/recipes/tuscan-sausage-and-pepper-spaghetti-5ab3b0d130006c3665546132?locale=en-US',
#   'https://www.hellofresh.com/recipes/quick-sausage-bolognese-59837f08a2882a4e0168d443?locale=en-US',
#   'https://www.hellofresh.com/recipes/one-pan-chicken-alfredo-59033052c6243b049f065022?locale=en-US',
#   'https://www.hellofresh.com/recipes/tomato-garlic-ragu-wildfire-w40-57d06d3fd804b57d468b4568?locale=en-US',
#   'https://www.hellofresh.com/recipes/uk-shrimp-and-chorizo-pasta-581213efa7c72a6c4c5e4322?locale=en-US',
#   'https://www.hellofresh.com/recipes/uk-melt-in-the-middle-meatballs-57558e5b4dab7189498b4567?locale=en-US',
#   'https://www.hellofresh.com/recipes/spaghetti-squash-saute-5566233e4dab716f7d8b456d?locale=en-US',
#   'https://www.hellofresh.com/recipes/crushed-beets-whole-wheat-spaghetti-5566221afd2cb9046d8b456b?locale=en-US',
#   'https://www.hellofresh.com/recipes/roasted-butternut-squash-leek-hash-5509802a6ced6e33698b4573?locale=en-US',
#   'https://www.hellofresh.com/recipes/sausage-pizzas-for-dinner-5b5b497c30006c3d48524f72?locale=en-US',
#   'https://www.hellofresh.com/recipes/pulled-pork-mac-n-cheese-5b0334d330006c15c4372b62?locale=en-US',
#   'https://www.hellofresh.com/recipes/parmesan-crusted-chicken-5afb44b8ae08b553bb3364e2?locale=en-US',
#   'https://www.hellofresh.com/recipes/w31-r8-5b16fa99ae08b55d5e3718c2?locale=en-US',
#   'https://www.hellofresh.com/recipes/sausage-pizzas-for-dinner-5b5b497c30006c3d48524f72?locale=en-US',
#   'https://www.hellofresh.com/recipes/creamy-shrimp-tagliatelle-5a8f0fcbae08b52f161b5832?locale=en-US',
#   'https://www.hellofresh.com/recipes/penne-primavera-5a8360ffae08b51fba45e622?locale=en-US',
#   'https://www.hellofresh.com/recipes/tomato-y-tortelloni-soup-5a7a2eadae08b52d2b47e082?locale=en-US',
#   'https://www.hellofresh.com/recipes/butternut-squash-agnolotti-5a7a30b330006c46d9573642?locale=en-US'
# ]

# urls.each do |url|
#   html_file = open(url).read
#   doc = Nokogiri::HTML(html_file)

#   puts "Fetching url # #{urls.index(url)}........."

#   puts "Creating recipes..."
#   @recipe = Recipe.new({
#     name: doc.search('.fela-y6xryt')[0].text.strip,
#     calories: doc.search('.fela-107ja4p')[5].text.strip,
#     difficulty: "default",
#     # difficulty: doc.search('.fela-107ja4p')[3].text.strip,
#     serves: 2,
#     # serves: doc.search('.fela-1cznd19')[0].text.strip,
#     time: doc.search('.fela-107ja4p')[2].text.strip,
#     description: doc.search('.fela-16ygip7 p')[0].text.strip,
#     steps: {},
#     photo: doc.search('.fela-1b1idjb').attr('src')

#   },
#   );

#   i = 1
#   doc.search('.fela-1qsq4x8').each do |step|
#     @recipe.steps[i] = step.text.strip
#     i += 1
#   end

#   @recipe.save!

#   puts "Created #{Recipe.all.length} recipes"


#   puts "Creating ingredient families..."
#   IngredientFamily.create!([
#     {
#       name: "cheese",
#     },
#     {
#       name: "herbs",
#     },
#     {
#       name: "meat",
#     },
#     {
#       name: "vegetables",
#     },
#     {
#       name: "pasta",
#     }
#   ]);
#   puts "Created #{IngredientFamily.all.length} recipes"


#   puts "Creating ingredients and measurements..."
#   counter = 0
#   while counter < doc.search('.fela-bj2f19').length
#     @ingredient = Ingredient.find_by(name: doc.search('.fela-c30jy9')[counter].text.strip)
#     measurements = doc.search('.fela-2htk9c')[counter].text.strip.split(" ")
#     given_price = [10, 25, 3, 18].sample
#     @ingredient ||= Ingredient.new(
#     {
#       name: doc.search('.fela-c30jy9')[counter].text.strip,
#       photo: "",
#       vegan: true,
#       vegetarian: true,
#       ingredient_family_id: 2,
#       base: false,
#       topping: false,
#       seasoning: true,
#       unit: measurements[1],
#       price: given_price
#     },
#     );
#     @ingredient.save!
#     measurements = doc.search('.fela-2htk9c')[counter].text.strip.split(" ")
#     Measurement.create!([
#       {
#         ingredient_id: @ingredient.id,
#         recipe_id: @recipe.id,
#         value: measurements[0]
#       },
#     ]);
#     counter += 1
#   end
#   puts "Created #{Ingredient.all.length} ingredients"
#   puts "Created #{Measurement.all.length} measurements"
#   sleep(1)
# end

# puts "Creating shopping lists..."
# ShoppingList.create!([
#   {
#     user_id: 1,
#     total_price: 100
#   },
#   {
#     user_id: 2,
#     total_price: 400
#   },
#   {
#     user_id: 3,
#     total_price: 150
#   }
# ]);
# puts "Created #{ShoppingList.all.length} shopping lists"


# puts "Creating measurement shopping lists..."
# MeasurementShoppingList.create!([
#   {
#     shopping_list_id: 1,
#     measurement_id: 1
#   },
#   {
#     shopping_list_id: 1,
#     measurement_id: 2
#   },
#   {
#     shopping_list_id: 1,
#     measurement_id: 3
#   },
#   {
#     shopping_list_id: 1,
#     measurement_id: 4
#   },
#   {
#     shopping_list_id: 1,
#     measurement_id: 5
#   },
#   {
#     shopping_list_id: 1,
#     measurement_id: 86
#   },
#   {
#     shopping_list_id: 1,
#     measurement_id: 80
#   },
#   {
#     shopping_list_id: 1,
#     measurement_id: 81
#   },
#   {
#     shopping_list_id: 1,
#     measurement_id: 84
#   },
#   {
#     shopping_list_id: 1,
#     measurement_id: 33
#   },
#   # this one has nil value
#   # {
#   #   shopping_list_id: 1,
#   #   measurement_id: 54,
#   #   price: 20
#   # },
#   {
#     shopping_list_id: 2,
#     measurement_id: 2
#   },
#   {
#     shopping_list_id: 3,
#     measurement_id: 2
#   }
# ]);
# puts "Created #{MeasurementShoppingList.all.length} measurements shopping lists"


# # puts "Creating recipeuser...."
# # RecipeUser.create!([
# #   {
# #     recipe_id: 1,
# #     user_id: 2,
# #   },
# #   {
# #     recipe_id: 2,
# #     user_id: 1,
# #   }
# # ]);

# # puts "Created #{RecipeUser.all.length} Recipe Users"




# NEW SCRAPING SCRIPT

require "open-uri"
require "nokogiri"

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
#END SCRAPING INGREDIENTS--------------------------------------------------------

#SCRAPING MEASUREMENTS-----------------------------------------------------------
#   counter = 0
#   while counter < doc.search('.fela-bj2f19').length
#     @ingredient = Ingredient.find_by(name: doc.search('.fela-c30jy9')[counter].text.strip)
#     measurements = doc.search('.fela-2htk9c')[counter].text.strip.split(" ")
#     given_price = [10, 25, 3, 18].sample
#     @ingredient ||= Ingredient.new(
#     {
#       name: doc.search('.fela-c30jy9')[counter].text.strip,
#       photo: "",
#       vegan: true,
#       vegetarian: true,
#       ingredient_family_id: 2,
#       base: false,
#       topping: false,
#       seasoning: true,
#       unit: measurements[1],
#       price: given_price
#     },
#     );
#     @ingredient.save!
#     measurements = doc.search('.fela-2htk9c')[counter].text.strip.split(" ")
#     Measurement.create!([
#       {
#         ingredient_id: @ingredient.id,
#         recipe_id: @recipe.id,
#         value: measurements[0]
#       },
#     ]);
#     counter += 1
#   end
#END SCRAPING MEASUREMENTS-------------------------------------------------------

sleep(1)
end
