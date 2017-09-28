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
  erb :categories
end

post '/recipes' do
  name = params.fetch 'name'
  instructions = params.fetch 'instructions'
  rating = params.fetch 'rating'
  category = params.fetch 'category'
  cat = Category.find_or_initialize_by group: category
  cat.save
  recipe = Recipe.create({:name => name, :instruction => instructions, :rating => rating})

  recipe.categories.push(cat)

  ingredients = params.fetch('ingredients').split(', ')
  ingredients.each do |ingredient|
    ing = Ingredient.find_or_initialize_by name: ingredient
    recipe.ingredients.push(ing)
  end

  redirect '/recipes'
end

post '/categories' do
  group = params.fetch 'group'
  Category.create({:group => group})
  redirect '/categories'
end

get '/recipes/:id' do
  @recipe = Recipe.find(params.fetch('id').to_i)
  # binding.pry
  @categories = @recipe.categories

  erb :recipe
end

get '/categories/:id' do
  # @category = Category.find(params.fetch('id').to_i)
  # @recipes = Recipe.find(params.fetch('id').to_i)
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
