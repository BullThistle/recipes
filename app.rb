require 'bundler/setup'
Bundler.require :default
require 'pry'

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get '/' do
  erb :index
end

get '/recipes' do
  @recipes = Recipe.all
  erb :recipes
end

get '/categories' do
  @categories = Category.all
  @categories.each do |category|
    if category.recipes == []
      category.destroy
    end
  end
  erb :categories
end

get '/ingredients' do
  @ingredients = Ingredient.all
  @ingredients.each do |ingredient|
    if ingredient.recipes == []
      ingredient.destroy
    end
  end
  erb :ingredients
end

get '/add' do
  erb :add
end

post '/add' do
  name = params.fetch 'name'
  instructions = params.fetch 'instructions'
  rating = params.fetch 'rating'

  recipe = Recipe.create({:name => name, :instruction => instructions, :rating => rating})

  categories = params.fetch('category').split('#')
  categories.each do |category|
    if category.length > 0
      cat = Category.find_or_initialize_by group: category
      cat.save
      recipe.categories.push(cat)
    end
  end

  ingredients = params.fetch('ingredients').split(', ')
  ingredients.each do |ingredient|
    ing = Ingredient.find_or_initialize_by name: ingredient
    recipe.ingredients.push(ing)
  end

  redirect '/recipes'
end

get '/recipes/:id' do
  @recipe = Recipe.find(params.fetch('id').to_i)
  @categories = @recipe.categories

  erb :recipe
end

get '/categories/:id' do
  @category = Category.find(params.fetch('id').to_i)
  @recipes = @category.recipes
  erb :category
end

get '/ingredients/:id' do
  @ingredient = Ingredient.find(params.fetch('id').to_i)
  @recipes = @ingredient.recipes
  erb :ingredient
end

delete '/recipes/:id' do
  recipe = Recipe.find(params.fetch(:id).to_i)
  recipe.destroy
  redirect '/recipes'
end

# patch '/recipes/:id' do
#   category_id = params.fetch('category_id').to_i
#   @recipe = Recipe.find(params.fetch('id').to_i)
#   @recipe.update({:category_id => category_id})
#   redirect back
# end

# patch '/categories/:id' do
#   recipe = Recipe.find(params.fetch('recipe_id').to_i)
#   @category = Category.find(params.fetch('id').to_i)
#   @category.recipes.push(recipe)
#   redirect back
# end
