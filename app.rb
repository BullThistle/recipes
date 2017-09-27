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
  recipe = Recipe.create({:name => name, :instructions => instructions, :rating => rating})

  recipe.categories.create({:group => cat})

  @ingredients = params.fetch('ingredients').split(', ')
  @ingredients.each do |ingredient|
    if Ingredient.exists?(name: ingredient)
      ing = ingredients.find(name: ingredient)
    else
      ing = Ingredient.create({:name => ingredient})
    end
    recipe.push(ing)
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
  if @recipe.categories
    @category = Category.find(@recipe.categories)
  else
    @category = nil
  end

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
