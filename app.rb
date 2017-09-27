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
  ingredients = params.fetch 'ingredients'
  instructions = params.fetch 'instructions'
  rating = params.fetch 'rating'
  Recipe.create({:name => name, :ingredients => ingredients, :instructions => instructions, :rating => rating})
  redirect '/recipes'
end

post '/categories' do
  group = params.fetch 'group'
  Category.create({:group => group})
  redirect '/categories'
end

get '/recipes/:id' do
  @recipe = Recipe.find(params.fetch('id').to_i)
  @categories = Category.all
  erb :recipe
end

get '/categories/:id' do
  @category = Category.find(params.fetch('id').to_i)
  @recipes = Recipe.find(params.fetch('id').to_i)
end

patch '/recipes/:id' do
  category_id = params.fetch('category_id').to_i
  @recipe = Recipe.find(params.fetch('id').to_i)
  @recipe.update({:category_id => category_id})
  redirect back
end

patch '/categories/:id' do
  recipe = Recipe.find(params.fetch('recipe_id').to_i)
  @category = Category.find(params.fetch('id').to_i)
  @category.recipes.push(recipe)
  redirect back
end
