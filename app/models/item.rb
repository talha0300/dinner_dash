class Item < ApplicationRecord
  has_one_attached :image
  has_many :categorizations
  has_many :categories, through: :categorizations
  has_many :cart_items
  has_many :carts,through: :cart_items


  def self.get_items(filter)
    if !filter or filter==="all"
      Item.all
    else
      Item.joins(:categories).where("categories.name":"#{filter}")
    end
  end


end
