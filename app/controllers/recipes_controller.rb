class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def new
    @items = Item.all
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.save
    redirect_to recipes_path
  end

  def edit
    @items = Item.all
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
#    if @recipe.touch
    if @recipe.update(recipe_params)
      redirect_to recipes_path
    else
      render edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

  private
  def recipe_params
    params.require(:recipe).permit(:result_id)
  end

end
