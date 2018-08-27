@ingredients = Ingredient.all

@ingredients.each do |ingredient|
  if ingredient.name == "ricotta"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/v1535201319/Recipeasy/ricotta.jpg'
  elsif ingredient.name == "tagliatelle"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/v1535201318/Recipeasy/tagliatelle.jpg'
  elsif ingredient.name == "spaghetti"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/v1535201317/Recipeasy/spaghetti.jpg'
  elsif ingredient.name == "hazelnuts"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/v1535201316/Recipeasy/hazelnuts.jpg'
  elsif ingredient.name == "prosciutto"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/v1535201316/Recipeasy/prosciutto.jpg'
  elsif ingredient.name == "pinenuts"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/v1535201316/Recipeasy/pinenuts.jpg'
  elsif ingredient.name == "peas"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/v1535201315/Recipeasy/peas.jpg'
  elsif ingredient.name == "honey"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/v1535201314/Recipeasy/honey.jpg'
  elsif ingredient.name == "carrots"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/v1535201312/Recipeasy/carrots.jpg'
  elsif ingredient.name == "fusilli"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/v1535201312/Recipeasy/fusilli.jpg'
  elsif ingredient.name == "bell pepper"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/v1535201312/Recipeasy/bellpepper.jpg'
  elsif ingredient.name == "eggplant"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/v1535201312/Recipeasy/eggplant.jpg'
  elsif ingredient.name == "broccoli"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/v1535201311/Recipeasy/broccoli.jpg'
  elsif ingredient.name == "arugola"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/v1535201310/Recipeasy/arugola.jpg'
  elsif ingredient.name == "asparagus"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/v1535201310/Recipeasy/asparagus.jpg'
  elsif ingredient.name == "avocado"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/v1535201310/Recipeasy/avocado.jpg'
  elsif ingredient.name == "zucchini"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/v1535200978/Recipeasy/zucchini.jpg'
  elsif ingredient.name == "spinach"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/v1535200972/Recipeasy/spinach.jpg'
  elsif ingredient.name == "tomatoes"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/v1535200972/Recipeasy/tomato.jpg'
  elsif ingredient.name == "onions"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/v1535200968/Recipeasy/onion.jpg'
  elsif ingredient.name == "mushrooms"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/v1535200972/Recipeasy/mushroom.jpg'
  elsif ingredient.name == "egg"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/v1535200970/Recipeasy/eggs.jpg'
  elsif ingredient.name == "goat cheese"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/v1535200970/Recipeasy/goat_cheese.jpg'
  elsif ingredient.name == "mozzarella"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/v1535200970/Recipeasy/Mozzarella.jpg'
  elsif ingredient.name == "garlic"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/v1535200969/Recipeasy/garlic.jpg'
  elsif ingredient.name == "leek"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/v1535200969/Recipeasy/leek.jpg'
  elsif ingredient.name == "beef"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/v1535200969/Recipeasy/beef.jpg'
  elsif ingredient.name == "potatoes"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/v1535200968/Recipeasy/potato.jpg'
  elsif ingredient.name == "pecorino"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/v1535200968/Recipeasy/Pecorino.jpg'
  elsif ingredient.name == "chili"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/v1535200968/Recipeasy/chili.jpg'
  elsif ingredient.name == "basil"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/v1535200968/Recipeasy/basil.jpg'
  elsif ingredient.name == "chicken"
    ingredient.remote_photo_url = 'https://res.cloudinary.com/decmti7fk/image/upload/v1535373966/Recipeasy/chicken.jpg'
end
