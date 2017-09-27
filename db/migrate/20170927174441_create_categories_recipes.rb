class CreateCategoriesRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :categories_recipes do |t|
      t.column :categories_id, :integer
      t.column :recipes_id, :integer
      
      t.timestamps
    end
  end
end
