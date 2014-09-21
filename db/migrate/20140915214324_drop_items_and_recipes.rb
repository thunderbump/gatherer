class DropItemsAndRecipes < ActiveRecord::Migration
  def change
    drop_table :items_and_recipes
  end
end
