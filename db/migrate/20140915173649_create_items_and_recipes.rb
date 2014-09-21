class CreateItemsAndRecipes < ActiveRecord::Migration
  def change
    create_table :items_and_recipes, id: false do |t|
      t.belongs_to :item
      t.belongs_to :recipe
    end
  end
end
