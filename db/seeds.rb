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

# SCRAPING RECIPES, INGREDIENTS AND MEASUREMENTS---------------------------------------------------------------
@recipes_urls.uniq!
@recipes_urls.each do |url|
  html_file = open(url).read
  doc = Nokogiri::HTML(html_file)

  puts "Creating recipe #{@recipes_urls.index(url)}...."

  new_recipe = Recipe.new(
  {
    name: doc.search('.recipe-title').text.strip,
    photo: doc.search('.recipe-header__image-container img').first.values[1],
    calories: doc.search('.recipe-nutrition .col-1 span')[1].try(:text),
    fat: doc.search('.recipe-nutrition .col-3 span')[1].try(:text),
    carb: doc.search('.recipe-nutrition .col-4 span')[1].try(:text),
    protein: doc.search('.recipe-nutrition .col-2 span')[1].try(:text),
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

  # getting the list of overal ingredient that will be searchable in the shuffle option of the app
  # => e.g.: (canned tomatoes, crushed tomatoes,...) => tomatoes
  clean_ingredients = Ingredient.ingredient_names

  # scraping ingredients and their value/unit from the website and putting them into separate arrays
  counter = 0
  scraped_ingredients = []
  scraped_measurements_unit = []
  scraped_measurements_value = []
  while counter < doc.search('.ingredients tr').length
    doc.search('.ingredients tr .ingredients__col-2')[counter].text.strip
    scraped_ingredients << doc.search('.ingredients tr .ingredients__col-2')[counter].text.strip
    doc.search('.ingredients tr .ingredients__col-1')[counter].attr('data-unit')
    scraped_measurements_unit << doc.search('.ingredients tr .ingredients__col-1')[counter].attr('data-unit')
    doc.search('.ingredients tr .ingredients__col-1')[counter].attr('data-amount')
    scraped_measurements_value << doc.search('.ingredients tr .ingredients__col-1')[counter].attr('data-amount')
    counter += 1
  end

  scraped_ingredients_reference = scraped_ingredients

  # for the ingredients having no value/unit, replacing the 'nil' value scraped by a string 'none' to avoid errors in the script
  scraped_ingredients.map! {|e| e ? e : "none"}
  scraped_measurements_unit.map! {|e| e ? e : " "}
  scraped_measurements_value.map! {|e| e ? e : " "}

  # start to create ingredients and measurements in the db, based on the scraped arrays
  scraped_ingredients.each do |scraped_ingredient|
    scraped_ingredient.downcase!
    index_counter =  scraped_ingredients_reference.index(scraped_ingredient)
    # first we check if scraped ingredients are not part of the clean list
    clean_ingredients.select do |clean_name|
      if scraped_ingredient.include?(clean_name) || scraped_ingredient.include?(clean_name.pluralize)
        # for the ingredients that are part of the clean list, check if this ingredient already exists in the db
        ingredient_found = Ingredient.where(name: clean_name).first
        if ingredient_found
          p ingredient_found.name
          # ingredient already exists so we only have to create a new measurements and link to the id of the existing ingrediente
          measurement = Measurement.new
          measurement.ingredient_id = ingredient_found.id
          measurement.recipe_id = new_recipe.id
          measurement.display_name = scraped_ingredient
          # index_counter =  scraped_ingredients.index(scraped_ingredient)
          # normalisation of the value/unit to only keep values refered in grams or milliliters
          if ingredient_found.unit == "kg"
            measurement.value = scraped_measurements_value[index_counter].to_f*1000
            ingredient_found.unit = "g"
          elsif ingredient_found.unit == "l"
            measurement.value = scraped_measurements_value[index_counter].to_f*1000
            ingredient_found.unit = "ml"
          else
            measurement.value = scraped_measurements_value[index_counter].to_f
          end
          measurement.save!
          # removing ingredient created from the scraped array (same for unit and value)
          # scraped_ingredients.delete_at(index_counter)
          # scraped_measurements_value.delete_at(index_counter)
          # scraped_measurements_unit.delete_at(index_counter)

        else
          # ingredient that is part of the clean list does not exist yet so we have to create it first
          ingredient = Ingredient.new(
            name: clean_name
            )
          ingredient.unit = scraped_measurements_unit[scraped_ingredients.index(scraped_ingredient)]
          ingredient.save!
          p ingredient.name
          # create the measurement for this new ingredient
          measurement = Measurement.new
          measurement.ingredient_id = ingredient.id
          measurement.recipe_id = new_recipe.id
          measurement.display_name =  scraped_ingredient
          # index_counter =  scraped_ingredients.index(scraped_ingredient)
          # normalisation of the value/unit to only keep values refered in grams or milliliters
          if ingredient.unit == "kg"
            measurement.value = scraped_measurements_value[index_counter].to_f*1000
            ingredient.unit = "g"
          elsif ingredient.unit == "l"
            measurement.value = scraped_measurements_value[index_counter].to_f*1000
            ingredient.unit = "ml"
          else
            measurement.value = scraped_measurements_value[index_counter].to_f
          end
          measurement.save!
          # removing ingredient created from the scraped array (same for unit and value)
          # scraped_ingredients.delete_at(index_counter)
          # scraped_measurements_value.delete_at(index_counter)
          # scraped_measurements_unit.delete_at(index_counter)

        end
        scraped_ingredients.delete_at(index_counter)
        scraped_measurements_value.delete_at(index_counter)
        scraped_measurements_unit.delete_at(index_counter)
      end
    end
  end

  # => At this point, the scraped_ingredients, scraped_measurements_unit and scraped_measurements_value arrays only contains information about ingredients that are not part of the clean list

  # create ingredients remaining in the scraped_ingredients array
  scraped_ingredients.each do |scraped_ingredient|
    scraped_ingredient.downcase!
    ingredient_unclean = Ingredient.where(name: scraped_ingredient).first
    #if ingredient already exists
    if ingredient_unclean.present?
      p ingredient_unclean.name
      measurement = Measurement.new
      measurement.ingredient_id = ingredient_unclean.id
      measurement.recipe_id = new_recipe.id
      measurement.display_name = scraped_ingredient
      # normalisation of the value/unit to only keep values refered in grams or milliliters
      if ingredient_unclean.unit == "kg"
        measurement.value = scraped_measurements_value[scraped_ingredients.index(scraped_ingredient)].to_f*1000
        ingredient_unclean.unit = "g"
      elsif ingredient_unclean.unit == "l"
        measurement.value = scraped_measurements_value[scraped_ingredients.index(scraped_ingredient)].to_f*1000
        ingredient_unclean.unit = "ml"
      else
        measurement.value = scraped_measurements_value[scraped_ingredients.index(scraped_ingredient)].to_f
      end
      measurement.save!
    #if ingredient does not exist yet
    else
      ingredient_unclean_new = Ingredient.new(name: scraped_ingredient)
      ingredient_unclean_new.unit = scraped_measurements_unit[scraped_ingredients.index(scraped_ingredient)]
      ingredient_unclean_new.save!
      p ingredient_unclean_new.name
      measurement = Measurement.new
      measurement.ingredient_id = ingredient_unclean_new.id
      measurement.recipe_id = new_recipe.id
      measurement.display_name = scraped_ingredient
      # normalisation of the value/unit to only keep values refered in grams or milliliters
      if ingredient_unclean_new.unit == "kg"
        measurement.value = scraped_measurements_value[scraped_ingredients.index(scraped_ingredient)].to_f*1000
        ingredient_unclean_new.unit = "g"
      elsif ingredient_unclean_new.unit == "l"
        measurement.value = scraped_measurements_value[scraped_ingredients.index(scraped_ingredient)].to_f*1000
        ingredient_unclean_new.unit = "ml"
      else
        measurement.value = scraped_measurements_value[scraped_ingredients.index(scraped_ingredient)].to_f
      end
      measurement.save!
    end
  end
  # wait for 1 second before creating following recipe
  p Measurement.count
  sleep(1)
end
  # END SCRAPING RECIPES, INGREDIENTS AND MEASUREMENTS-----------------------------------------------------------


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


puts "Creating ingredient pictures..."

Ingredient.clean_ingredients.each do |ingredient|
  if ingredient.name == "ricotta"
    ingredient.remote_photo_url = "https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535201319/Recipeasy/ricotta.jpg"
    ingredient.save!
  elsif ingredient.name == "tagliatelle"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535201318/Recipeasy/tagliatelle.jpg'
    ingredient.save!
  elsif ingredient.name == "spaghetti"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535201317/Recipeasy/spaghetti.jpg'
    ingredient.save!
  elsif ingredient.name == "hazelnuts"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535201316/Recipeasy/hazelnuts.jpg'
    ingredient.save!
  elsif ingredient.name == "prosciutto"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535201316/Recipeasy/prosciutto.jpg'
    ingredient.save!
  elsif ingredient.name == "pinenuts"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535201316/Recipeasy/pinenuts.jpg'
    ingredient.save!
  elsif ingredient.name == "peas"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535201315/Recipeasy/peas.jpg'
    ingredient.save!
  elsif ingredient.name == "honey"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535201314/Recipeasy/honey.jpg'
    ingredient.save!
  elsif ingredient.name == "carrots"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535201312/Recipeasy/carrots.jpg'
    ingredient.save!
  elsif ingredient.name == "fusilli"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535201312/Recipeasy/fusilli.jpg'
    ingredient.save!
  elsif ingredient.name == "bell pepper"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535201312/Recipeasy/bellpepper.jpg'
    ingredient.save!
  elsif ingredient.name == "eggplant"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535201312/Recipeasy/eggplant.jpg'
    ingredient.save!
  elsif ingredient.name == "broccoli"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535201311/Recipeasy/broccoli.jpg'
    ingredient.save!
  elsif ingredient.name == "arugola"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535201310/Recipeasy/arugola.jpg'
    ingredient.save!
  elsif ingredient.name == "asparagus"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535201310/Recipeasy/asparagus.jpg'
    ingredient.save!
  elsif ingredient.name == "avocado"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535201310/Recipeasy/avocado.jpg'
    ingredient.save!
  elsif ingredient.name == "zucchini"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535200978/Recipeasy/zucchini.jpg'
    ingredient.save!
  elsif ingredient.name == "spinach"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535200972/Recipeasy/spinach.jpg'
    ingredient.save!
  elsif ingredient.name == "tomatoes"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535200972/Recipeasy/tomato.jpg'
    ingredient.save!
  elsif ingredient.name == "onions"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535200968/Recipeasy/onion.jpg'
    ingredient.save!
  elsif ingredient.name == "mushrooms"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535200972/Recipeasy/mushroom.jpg'
    ingredient.save!
  elsif ingredient.name == "egg"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535200970/Recipeasy/eggs.jpg'
    ingredient.save!
  elsif ingredient.name == "goat cheese"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535200970/Recipeasy/goat_cheese.jpg'
    ingredient.save!
  elsif ingredient.name == "mozzarella"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535200970/Recipeasy/Mozzarella.jpg'
    ingredient.save!
  elsif ingredient.name == "garlic"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535200969/Recipeasy/garlic.jpg'
    ingredient.save!
  elsif ingredient.name == "leek"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535200969/Recipeasy/leek.jpg'
    ingredient.save!
  elsif ingredient.name == "beef"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535536402/Recipeasy/new_ingredients/meat.jpg'
    ingredient.save!
  elsif ingredient.name == "potatoes"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535200968/Recipeasy/potato.jpg'
    ingredient.save!
  elsif ingredient.name == "pecorino"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535200968/Recipeasy/Pecorino.jpg'
    ingredient.save!
  elsif ingredient.name == "chili"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535200968/Recipeasy/chili.jpg'
    ingredient.save!
  elsif ingredient.name == "basil"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535200968/Recipeasy/basil.jpg'
    ingredient.save!
  elsif ingredient.name == "chicken"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535373966/Recipeasy/chicken.jpg'
    ingredient.save!
  elsif ingredient.name == "thyme"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535536403/Recipeasy/new_ingredients/thyme.jpg'
    ingredient.save!
  elsif ingredient.name == "shallot"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535536403/Recipeasy/new_ingredients/red_shallots.jpg'
    ingredient.save!
  elsif ingredient.name == "penne"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535536403/Recipeasy/new_ingredients/penne.jpg'
    ingredient.save!
  elsif ingredient.name == "macaroni"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535536403/Recipeasy/new_ingredients/macaroni.jpg'
    ingredient.save!
  elsif ingredient.name == "pancetta"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535536402/Recipeasy/new_ingredients/ham.jpg'
    ingredient.save!
  elsif ingredient.name == "parmesan"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535536404/Recipeasy/new_ingredients/parmesan.jpg'
    ingredient.save!
  elsif ingredient.name == "arugula"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535536403/Recipeasy/new_ingredients/rocket.jpg'
    ingredient.save!
  elsif ingredient.name == "mascarpone"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535536403/Recipeasy/new_ingredients/Mascarpone.jpg'
    ingredient.save!
  elsif ingredient.name == "linguine"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535536402/Recipeasy/new_ingredients/Linguini.jpg'
    ingredient.save!
  elsif ingredient.name == "gorgonzola"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535536402/Recipeasy/new_ingredients/gorgonzola.jpg'
    ingredient.save!
  else
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/c_fill,g_center,h_750,w_400/v1535373966/Recipeasy/chicken.jpg'
    ingredient.save!
  end
end
