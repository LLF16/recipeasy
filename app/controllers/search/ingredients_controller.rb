class Search::IngredientsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @ingredients_received = []
    @ingredients_received << Ingredient.where(name: "#{params[:first]}")
    @ingredients_received << Ingredient.where(name: "#{params[:second]}")
    @ingredients_received << Ingredient.where(name: "#{params[:third]}")
    @ingredients_received << Ingredient.where(name: "#{params[:fourth]}")
        # binding.pry
    @original_received = @ingredients_received.dup
    a = @ingredients_received.delete([])
    @ingredients_received.flatten!

    @ingredients_to_send = []
    case @ingredients_received.length
    when 4
      @ingredients_to_send = @ingredients_received
    when 3
      get_one_random
    when 2
      get_two_random
    when 1
      get_three_random
    when 0
      get_four_random
    else
      puts "yooooooooooooooo"
    end

    # if @ingredients_received.length == 4
    #   @ingredients_to_send = @ingredients_received
    # elsif @ingredients_received.length == 3
    #   get_one_random
    # elsif @ingredients_received.length == 2
    #   get_two_random
    # elsif @ingredients_received.length == 1
    #   get_three_random
    # else
    #   raise
    # end

    counter = 0
    @result = []
    @original_received.each do |item|
      if item.empty?
        @result << @ingredients_to_send[counter]
        counter += 1
      else
        @result << item[0]
      end
    end

    # p "heeeeeeeyyyyyyyyyyyy"
    # p @original_received
    # p @ingredients_to_send
    # p @result

    render json: {
      first: @result.first,
      second: @result[1],
      third: @result[2],
      fourth: @result[3]
    }
    # respond_to do |format|
    #   format.html
    #   format.json{ @result }
    # end

  end

  # private

  def get_four_random
    @ingredient_1 = Ingredient.all.sample(1).first
    @recipes_with_ingredient_1 = @ingredient_1.recipes
    @ingredients_to_send << @ingredient_1

    @sample_ingredient_2 = Array.new
    @recipes_with_ingredient_1.each do |recipe|
      recipe.ingredients.each do |ingredient|
        if ingredient != @ingredient_1
          @sample_ingredient_2 << ingredient
        end
      end
    end
    @ingredient_2 = @sample_ingredient_2.shuffle.first
    @ingredients_to_send << @ingredient_2

    @recipes_with_ingredient_2 = @ingredient_2.recipes

    @recipes_with_ingredient_1_2 = @recipes_with_ingredient_2 & @recipes_with_ingredient_1

    @sample_ingredient_3 = Array.new
    @recipes_with_ingredient_1_2.each do |recipe|
      recipe.ingredients.each do |ingredient|
        if ingredient != @ingredient_1 && ingredient != @ingredient_2
          @sample_ingredient_3 << ingredient
        end
      end
    end
    @ingredient_3 = @sample_ingredient_3.shuffle.first
    @ingredients_to_send << @ingredient_3

    @recipes_with_ingredient_3 = @ingredient_3.recipes

    @recipes_with_ingredient_1_2_3 = @recipes_with_ingredient_1 & @recipes_with_ingredient_2 & @recipes_with_ingredient_3


    @sample_ingredient_4 = Array.new
    @recipes_with_ingredient_1_2_3.each do |recipe|
      recipe.ingredients.each do |ingredient|
        if ingredient != @ingredient_1 && ingredient != @ingredient_2 && ingredient != @ingredient_3
          @sample_ingredient_4 << ingredient
        end
      end
    end
    @ingredient_4 = @sample_ingredient_4.shuffle.first
    @ingredients_to_send << @ingredient_4
    return @ingredients_to_send
  end


  def get_three_random
    @ingredient_1 = @ingredients_received.first
    @recipes_with_ingredient_1 = @ingredient_1.recipes

    @sample_ingredient_2 = Array.new
    @recipes_with_ingredient_1.each do |recipe|
      recipe.ingredients.each do |ingredient|
        if ingredient != @ingredient_1
          @sample_ingredient_2 << ingredient
        end
      end
    end
    @ingredient_2 = @sample_ingredient_2.shuffle.first

    @ingredients_to_send << @ingredient_2

    @recipes_with_ingredient_2 = @ingredient_2.recipes

    @recipes_with_ingredient_1_2 = @recipes_with_ingredient_2 & @recipes_with_ingredient_1
    # p @recipes_with_ingredient_1_2
    # puts "i'm here"

    @sample_ingredient_3 = Array.new
    @recipes_with_ingredient_1_2.each do |recipe|
      recipe.ingredients.each do |ingredient|
        if ingredient != @ingredient_1 && ingredient != @ingredient_2
          @sample_ingredient_3 << ingredient
        end
      end
    end
    @ingredient_3 = @sample_ingredient_3.shuffle.first
    @ingredients_to_send << @ingredient_3

    @recipes_with_ingredient_3 = @ingredient_3.recipes

    @recipes_with_ingredient_1_2_3 = @recipes_with_ingredient_1 & @recipes_with_ingredient_2 & @recipes_with_ingredient_3

    @sample_ingredient_4 = Array.new
    @recipes_with_ingredient_1_2_3.each do |recipe|
      recipe.ingredients.each do |ingredient|
        if ingredient != @ingredient_1 && ingredient != @ingredient_2 && ingredient != @ingredient_3
          @sample_ingredient_4 << ingredient
        end
      end
    end
    @ingredient_4 = @sample_ingredient_4.shuffle.first
    @ingredients_to_send << @ingredient_4
    return @ingredients_to_send
  end

  def get_two_random
    @ingredient_1 = @ingredients_received.first
    @ingredient_2 = @ingredients_received[1]

    @recipes_with_ingredient_1 = @ingredient_1.recipes
    @recipes_with_ingredient_2 = @ingredient_2.recipes

    @recipes_with_ingredient_1_2 = @recipes_with_ingredient_2 & @recipes_with_ingredient_1

    @sample_ingredient_3 = Array.new
    @recipes_with_ingredient_1_2.each do |recipe|
      recipe.ingredients.each do |ingredient|
        if ingredient != @ingredient_1 && ingredient != @ingredient_2
          @sample_ingredient_3 << ingredient
        end
      end
    end

    @ingredient_3 = @sample_ingredient_3.shuffle.first
    @ingredients_to_send << @ingredient_3

    @recipes_with_ingredient_3 = @ingredient_3.recipes

    @recipes_with_ingredient_1_2_3 = @recipes_with_ingredient_1 & @recipes_with_ingredient_2 & @recipes_with_ingredient_3

    @sample_ingredient_4 = Array.new
    @recipes_with_ingredient_1_2_3.each do |recipe|
      recipe.ingredients.each do |ingredient|
        if ingredient != @ingredient_1 && ingredient != @ingredient_2 && ingredient != @ingredient_3
          @sample_ingredient_4 << ingredient
        end
      end
    end
    @ingredient_4 = @sample_ingredient_4.shuffle.first
    @ingredients_to_send << @ingredient_4
    return @ingredients_to_send
  end

  def get_one_random
    @ingredient_1 = @ingredients_received.first
    @ingredient_2 = @ingredients_received[1]
    @ingredient_3 = @ingredients_received[2]

    @recipes_with_ingredient_1 = @ingredient_1.recipes
    @recipes_with_ingredient_2 = @ingredient_2.recipes
    @recipes_with_ingredient_3 = @ingredient_3.recipes

    @recipes_with_ingredient_1_2_3 = @recipes_with_ingredient_1 & @recipes_with_ingredient_2 & @recipes_with_ingredient_3

    @sample_ingredient_4 = Array.new
    @recipes_with_ingredient_1_2_3.each do |recipe|
      recipe.ingredients.each do |ingredient|
        if ingredient != @ingredient_1 && ingredient != @ingredient_2 && ingredient != @ingredient_3
          @sample_ingredient_4 << ingredient
        end
      end
    end
    @ingredient_4 = @sample_ingredient_4.shuffle.first
    @ingredients_to_send << @ingredient_4
    return @ingredients_to_send
  end
end
