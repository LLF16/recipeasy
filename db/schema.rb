# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_08_27_091307) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "beverage_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "beverages", force: :cascade do |t|
    t.bigint "beverage_category_id"
    t.string "name"
    t.integer "vintage"
    t.text "description"
    t.boolean "alcohol"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["beverage_category_id"], name: "index_beverages_on_beverage_category_id"
  end

  create_table "ingredient_families", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingredients", force: :cascade do |t|
    t.bigint "ingredient_family_id"
    t.string "name"
    t.string "photo"
    t.boolean "vegan"
    t.boolean "vegetarian"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "base"
    t.boolean "topping"
    t.boolean "seasoning"
    t.float "price"
    t.index ["ingredient_family_id"], name: "index_ingredients_on_ingredient_family_id"
  end

  create_table "measurement_shopping_lists", force: :cascade do |t|
    t.bigint "shopping_list_id"
    t.bigint "measurement_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["measurement_id"], name: "index_measurement_shopping_lists_on_measurement_id"
    t.index ["shopping_list_id"], name: "index_measurement_shopping_lists_on_shopping_list_id"
  end

  create_table "measurements", force: :cascade do |t|
    t.bigint "ingredient_id"
    t.bigint "recipe_id"
    t.float "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "display_name"
    t.string "unit"
    t.index ["ingredient_id"], name: "index_measurements_on_ingredient_id"
    t.index ["recipe_id"], name: "index_measurements_on_recipe_id"
  end

  create_table "recipe_beverages", force: :cascade do |t|
    t.bigint "beverage_id"
    t.bigint "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["beverage_id"], name: "index_recipe_beverages_on_beverage_id"
    t.index ["recipe_id"], name: "index_recipe_beverages_on_recipe_id"
  end

  create_table "recipe_users", force: :cascade do |t|
    t.bigint "recipe_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_recipe_users_on_recipe_id"
    t.index ["user_id"], name: "index_recipe_users_on_user_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.text "steps"
    t.string "name"
    t.string "photo"
    t.integer "calories"
    t.integer "serves"
    t.string "time"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "carb"
    t.integer "fat"
    t.integer "protein"
    t.text "utensils"
    t.string "difficulty"
  end

  create_table "shopping_lists", force: :cascade do |t|
    t.bigint "user_id"
    t.float "total_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_shopping_lists_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.boolean "vegan"
    t.boolean "vegetarian"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "beverages", "beverage_categories"
  add_foreign_key "ingredients", "ingredient_families"
  add_foreign_key "measurement_shopping_lists", "measurements"
  add_foreign_key "measurement_shopping_lists", "shopping_lists"
  add_foreign_key "measurements", "ingredients"
  add_foreign_key "measurements", "recipes"
  add_foreign_key "recipe_beverages", "beverages"
  add_foreign_key "recipe_beverages", "recipes"
  add_foreign_key "recipe_users", "recipes"
  add_foreign_key "recipe_users", "users"
  add_foreign_key "shopping_lists", "users"
end
