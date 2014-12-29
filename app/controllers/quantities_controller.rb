class QuantitiesController < ApplicationController
  def destroy
    @quantity = Quantity.find(params[:id])
    return_id = @quantity.recipe_id
    @quantity.destroy
    redirect_to edit_recipe_path(id: return_id)
  end
end
