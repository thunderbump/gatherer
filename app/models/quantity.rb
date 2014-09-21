class Quantity < ActiveRecord::Base
  belongs_to :item
  belongs_to :recipe

  accepts_nested_attributes_for :item
end
