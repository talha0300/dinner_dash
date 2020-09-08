class Item < ApplicationRecord
  has_one_attached :image
  has_many:categories, through: :categorizations
  has_many :cart_items
  has_many :carts,through: :cart_items
end
