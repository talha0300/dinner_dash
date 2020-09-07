class Item < ApplicationRecord
  has_one_attached :image
  has_many:categories, through: :categorizations

  belongs_to :cart
end
