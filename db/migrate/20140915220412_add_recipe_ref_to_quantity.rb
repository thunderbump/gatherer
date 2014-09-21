class AddRecipeRefToQuantity < ActiveRecord::Migration
  def change
    add_reference :quantities, :recipe, index: true
  end
end
