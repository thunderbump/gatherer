class Recipe < ActiveRecord::Base
  belongs_to :result, class_name: "Item"

  has_many :quantities
  has_many :items, through: :quantities
end
