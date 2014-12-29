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

  #Edit
  #Params:
  #   (str)  id
  #   (str)  extrablank
  #
  #should lookup a recipe and add an amount of blank entries equal to @extrablank
  def edit
    params[:extrablank].nil? ? @extrablank = 1 : @extrablank = params[:extrablank].to_i
    @items = Item.all
    @recipe = Recipe.find(params[:id])
    @extrablank.times do
      @recipe.quantities.build
    end
    #    @ingredients ? @ingredients << Item.new : @ingredients = [Item.new]
  end

  #Update
  #Params:
  #   (str)  id
  #   (hash) recipe
  #     (str)  result_id
  #     (hash) quantities_attributes
  #       (hash) <attr index>
  #         (str)  result_id
  #         (str)  amount
  #         (str)  item_id
  #
  #Should update a recipe of given ID
  #Should not update a quantity if the amount or item id is null
  #
  def update
    @recipe = Recipe.find(params[:id])
    db_quantities = @recipe.quantities.where("recipe_id = :this_id", {this_id: @recipe.id})

    params[:recipe][:quantities_attributes].each do |quantity_raw|
      quantity = quantity_raw.to_a.last
      if quantity[:item_id].blank?
        next
      end
      #Look to see if the item name is already there and if it is, replace the new amount
      if db_quantities.map{|q| q.item_id}.include?(quantity[:item_id].to_i)
        (db_quantities.detect{|q| q.item_id == quantity[:item_id].to_i})
          .update(amount: quantity[:amount].to_i)
      else
        @recipe.add_item(quantity[:item_id], quantity[:amount])
      end

    end

    @recipe.attributes = recipe_params
    if @recipe.update_attributes(recipe_params)
      redirect_to edit_recipe_url, id: @recipe.id
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
    params.require(:recipe).permit(
      :result_id,
      :quantities => [
        :id,
        :amount,
        :item_id,
      ])
  end

end
