class Order < ApplicationRecord
  belongs_to :cart
  enum status: [:ordered,:completed,:cancelled]

  after_initialize do
    if self.new_record?
      self.status ||= :ordered
    end
  end

  def self.place_order(cart)
    total=Order.total_order_price(cart)
    order=Order.new(cart_id:cart.id,user_id:cart.user_id,total_amount:total)
    if order.save!
      order
    else
      false
    end
  end

  def self.total_order_price(cart)
    total=0
    cart_items= CartItem.joins("INNER JOIN items ON cart_items.item_id=items.id").where(cart_id:cart.id).pluck(:price,:quantity)
    cart_items.each do |item|
      total+=item[0]*item[1]
    end
    total
  end
end
