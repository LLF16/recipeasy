require "open-uri"
require "nokogiri"

class ScraperController


url ='https://www.hellofresh.com/recipes/chorizo-burgers-5b63796530006c374433cce2?locale=en-US'
html_file = open(url).read
doc = Nokogiri::HTML(html_file)

# @recipe = {
#     name: "",
#     photo: "",
#     description: "",
#     time: "",
#     difficulty: "",
#     serves: 2,
#     ingredients_list: [],
#     calories: "",
#     steps: {},
#   }

@ingredient = {
  name: "",
  photo: "",
}

@measurement = {
  ingredient_id: "",
  recipe_id: "",
  unit: "",
  value: ""
}


p @recipe = Recipe.cre

# -> SCRAPING NAME, DESCRIPTION, SERVES, DIFFICULTY, TIME, CALORIES AND PHOTO OF THE RECIPE
@recipe[:name] = doc.search('.fela-y6xryt')[0].text.strip
@recipe[:description] = doc.search('.fela-16ygip7 p')[0].text.strip
@recipe[:serves] = doc.search('.fela-1cznd19')[0].text.strip
@recipe[:difficulty] = doc.search('.fela-107ja4p')[3].text.strip
@recipe[:time] = doc.search('.fela-107ja4p')[2].text.strip
@recipe[:calories] = doc.search('.fela-107ja4p')[5].text.strip
@recipe[:photo] = doc.search('.fela-1b1idjb').attr('src')



counter = 0
while counter < doc.search('.fela-bj2f19').length
  @ingredient[:name] = doc.search('.fela-c30jy9')[counter].text.strip
  measurements = doc.search('.fela-2htk9c')[counter].text.strip.split(" ")
  @measurement[:unit] = measurements[1]
  @measurement[:value] = measurements[0]
  counter += 1
end

# -> SCRAPING THE DIFFERENT STEPS OF THE RECIPE
i = 1
doc.search('.fela-1qsq4x8').each do |step|
  @recipe[:steps][i] = step.text.strip
  i += 1
end

# puts @recipe


# puts Measurement.all
# puts Ingredient.all
# puts Recipe.all


end
