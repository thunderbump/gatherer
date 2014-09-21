class AddItemRefToQuantity < ActiveRecord::Migration
  def change
    add_reference :quantities, :item, index: true
  end
end
