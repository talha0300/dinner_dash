class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item


  def self.get_cart_items(cart)

    self.select("items.id, items.title,cart_items.quantity,items.price").joins("INNER JOIN items ON cart_items.item_id=items.id").where(cart_id:cart.id)
  end

  def self.total_cart_price(cart)
    total=0
    cart_items= self.get_cart_items(cart)
    cart_items.each do |item|
      total+=item[:price]*item[:quantity]
    end
    total
  end
end
