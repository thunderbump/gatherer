class Recipe < ActiveRecord::Base
  belongs_to :result, class_name: "Item"

  has_many :quantities
  has_many :items, through: :quantities

  accepts_nested_attributes_for :quantities

  def add_item(item_id, amount)
    added_item = quantities.find_by(item_id: item_id)
    if added_item
      added_item.amount += amount.to_i
    else
      added_item = quantities.build(item_id: item_id, amount: amount)
    end
    return added_item
  end
end
