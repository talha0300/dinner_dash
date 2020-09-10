class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item


  def self.get_cart_items(cart)
    #CartItem.joins("INNER JOIN items ON cart_items.item_id=items.id").where(cart_id:cart.id).pluck(:item_id,:title,:quantity)
    CartItem.select("items.id, items.title,cart_items.quantity").joins("INNER JOIN items ON cart_items.item_id=items.id").where(cart_id:cart.id)
  end
end
