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


# puts “Resetting IDs”
# ActiveRecord::Base.connection.tables.each do |t|
#  ActiveRecord::Base.connection.reset_pk_sequence!(t)
# end


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


puts "Creating recipes..."
Recipe.create!([
  {
    name: "Pasta all'amatriciana",
    calories: 100,
    difficulty: "hard",
    serves: 2,
    time: 30,
    description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eveniet ea nemo velit, maxime repellendus provident repudiandae magnam sequi dolor quaerat fuga, corporis magni quo quia beatae natus nulla non quas?",
    steps: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aperiam voluptatibus voluptatem quaerat corrupti repellendus, non explicabo suscipit maxime deserunt, illo omnis et perspiciatis quibusdam facere consectetur adipisci id doloribus tempore."
  },
  {
    name: "Spaghetti al pomodoro",
    calories: 70,
    difficulty: "easy",
    serves: 2,
    time: 50,
    description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Et ducimus, quod quia illo praesentium non fugiat. Illum quod pariatur expedita optio minus provident tempore accusantium, recusandae maiores ea, ullam dicta.",
    steps: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Error harum sunt dolores itaque dolor perferendis suscipit blanditiis earum corrupti quibusdam iste officiis doloremque eligendi fugiat, sint ipsam eaque. Velit, reprehenderit."
  },
  {
    name: "Pasta with vegetables",
    calories: 50,
    difficulty: "easy",
    serves: 2,
    time: 10,
    description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Deserunt doloremque quia ipsam, pariatur eveniet ex dicta laudantium nihil possimus, dolorem, reiciendis minus minima quod. Consectetur praesentium ea ipsa at vitae?",
    steps: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Tenetur nostrum, aspernatur, reprehenderit sequi neque illum. Hic consectetur totam veniam ut, sapiente. In error doloribus eaque qui aliquam consequuntur magni excepturi."
  },
  {
    name: "Pasta alla norma",
    calories: 120,
    difficulty: "easy",
    serves: 2,
    time: 20,
    description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Adipisci eaque, possimus maxime consequuntur hic inventore cum, reiciendis blanditiis dignissimos iusto accusamus voluptatibus quidem maiores fugiat sint nisi quos quia unde.",
    steps: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quibusdam doloribus inventore nostrum eius mollitia, corrupti a beatae voluptates aperiam aliquam veritatis provident, eum eos veniam ipsum repudiandae. Ut molestias, autem."
  }
]);
puts "Created #{Recipe.all.length} recipes"


puts "Creating ingredient families..."
IngredientFamily.create!([
  {
      name: "cheese",
  },
  {
    name: "herbs",
  },
  {
    name: "meat",
  },
  {
    name: "vegetables",
  },
  {
    name: "pasta",
  }
]);
puts "Created #{IngredientFamily.all.length} recipes"


puts "Creating ingredients..."
Ingredient.create!([
  {
    name: "Basil",
    photo: "",
    vegan: true,
    vegetarian: true,
    ingredient_family_id: 2,
    base: false,
    topping: false,
    seasoning: true
  },
  {
    name: "Minced Meat",
    photo: "",
    vegan: false,
    vegetarian: false,
    ingredient_family_id: 3,
    base: false,
    topping: true,
    seasoning: false
  },
  {
    name: "Tomato",
    photo: "",
    vegan: true,
    vegetarian: true,
    ingredient_family_id: 4,
    base: false,
    topping: true,
    seasoning: false
  },
  {
    name: "Pecorino",
    photo: "",
    vegan: false,
    vegetarian: true,
    ingredient_family_id: 1,
    base: false,
    topping: true,
    seasoning: false
  }
]);
puts "Created #{Ingredient.all.length} measurements"



puts "Creating measurements..."
Measurement.create!([{
    ingredient_id: 1,
    recipe_id: 1,
    unit: "kg",
    value: 1.0
  },
  {
    ingredient_id: 2,
    recipe_id: 2,
    unit: "liter",
    value: 2.5
  },
  {
    ingredient_id: 3,
    recipe_id: 1,
    unit: "grams",
    value: 100.0
  },
  {
    ingredient_id: 4,
    recipe_id: 4,
    unit: "milligrams",
    value: 1500.0
  }
]);
puts "Created #{Measurement.all.length} measurements"


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


puts "Creating measurment shopping lists..."
MeasurementShoppingList.create!([
  {
    shopping_list_id: 1,
    measurement_id: 1
  },
  {
    shopping_list_id: 1,
    measurement_id: 3
  },
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


puts "Creating recipeuser...."
RecipeUser.create!([
  {
    recipe_id: 1,
    user_id: 2,
  },
  {
    recipe_id: 2,
    user_id: 1,
  }
]);

puts "Created #{RecipeUser.all.length} Recipe Users"
