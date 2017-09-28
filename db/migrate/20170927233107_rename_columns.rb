class RenameColumns < ActiveRecord::Migration[5.1]
  def change
    rename_column :categories_recipes, :categories_id, :category_id
    rename_column :categories_recipes, :recipes_id, :recipe_id
    rename_column :ingredients_recipes, :ingredients_id, :ingredient_id
    rename_column :ingredients_recipes, :recipes_id, :recipe_id
    rename_column :recipes, :instructions, :instruction
  end
end
