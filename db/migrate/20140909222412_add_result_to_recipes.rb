class AddResultToRecipes < ActiveRecord::Migration
  def up
    add_reference :recipes, :result, index: true
  end
  
  def down
    remove_reference :recipes, :result
  end
end
