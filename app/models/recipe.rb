class Recipe < ActiveRecord::Base
  belongs_to :result, class_name: "Item"
end
