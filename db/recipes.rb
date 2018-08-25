require "open-uri"
require "nokogiri"

  # name = doc.search('.recipe-title').text.strip
  # calories = doc.search('.recipe-nutrition .col-1 span')[1].text.strip
  # protein = doc.search('.recipe-nutrition .col-2 span')[1].text.strip
  # fat = doc.search('.recipe-nutrition .col-3 span')[1].text.strip
  # carb = doc.search('.recipe-nutrition .col-4 span')[1].text.strip
  # difficulty =  doc.search('.recipe-difficulty span').text.strip
  # serves = doc.search('.stepper-value').text.strip
  # time = doc.search('.recipe-time .col-1 div').attr('data-time')
  # utensils = []
  # doc.search('.recipe-utensils .comma-separated-list li').each do |utensil|
  #   utensils << utensil.text.strip
  # end


  # steps = {}
  # recipe_steps = doc.search('.recipe-steps .step p').each do |step|
  #   # @recipe.steps[i] =
  #   step.text.strip
  #   # i += 1
  # end


clean_ingredients = %w(mozzarella tomato basil onion garlic potatoes mascarpone parmesan pecorino gorgonzola
  lasagne tagliatelle spaghetti macaroni penne conchiglie linguine leek pancetta chicken arugula spinach ricotta
  egg shallot chilli zucchini beef mushrooms prosciutto peas  fusilli  eggplant broccoli
  avocado carrots hazelnuts honey asparagus goatcheese bellpeppers pinenuts )


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

  # new_recipe = Recipe.new(
  # {
  recipe = doc.search('.recipe-title').text.strip
  photo = doc.search('.recipe-header__image-container img').first.values[1]
    # calories: doc.search('.recipe-nutrition .col-1 span')[1].text.strip,
    # fat: doc.search('.recipe-nutrition .col-3 span')[1].text.strip,
    # carb: doc.search('.recipe-nutrition .col-4 span')[1].text.strip,
    # protein: doc.search('.recipe-nutrition .col-2 span')[1].text.strip,
  difficulty = doc.search('.recipe-difficulty span').text
  #   time: doc.search('.recipe-time .col-1 div').attr('data-time'),
  #   serves: serves = doc.search('.stepper-value').text.strip,
  #   utensils: [],
  # })

  # doc.search('.recipe-utensils .comma-separated-list li').each do |utensil|
  #   new_recipe.utensils << utensil.text.strip
  # end

  # new_recipe.save!
  # p new_recipe

p recipe
p photo
p difficulty

  sleep(1)
end










#   counter = 0
#   ingredients = []
#   while counter < doc.search('.ingredients tr').length
#     ingredient = doc.search('.ingredients tr .ingredients__col-2')[counter].text.strip
#     ingredients << ingredient
#     counter += 1
#   end
#   ingredients.select do |ingredient|


# Ingredient.new(
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
#     },)

#   @ingredient.save!



#   @ingredient = Ingredient.find_by(name: doc.search('.fela-c30jy9')[counter].text.strip)
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
