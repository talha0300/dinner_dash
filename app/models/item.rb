class Item < ApplicationRecord
  has_one_attached :image
  has_many :categorizations,dependent: :destroy
  has_many :categories, through: :categorizations
  has_many :cart_items,dependent: :destroy
  has_many :carts,through: :cart_items

  has_many:favourite_items,dependent: :destroy


  def self.get_items(params)
    if !params[:filter] or params[:filter]==="all"
      Item.all
    elsif params[:filter]==="favourite"
      Item.joins(:favourite_items).where("user_id=#{params[:user].id}")
    else
      Item.joins(:categories).where("categories.name":"#{params[:filter]}")
    end
  end




end
