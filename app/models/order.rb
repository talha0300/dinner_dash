class Order < ApplicationRecord
  belongs_to :cart
  enum status: [:ordered,:completed,:cancelled,:paid]
  TYPE={ordered:"ordered",completed:"completed",cancelled:"cancelled",paid:"paid",all:"all"}

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
    cart_items= CartItem.get_cart_items(cart)
    cart_items.each do |item|
      total+=item[:price]*item[:quantity]
    end
    total
  end

  def self.get_orders(params)
    if params[:orders_type]===Order::TYPE[:all]
      orders=Order.all.order("created_at DESC")

    elsif params[:orders_type]===Order::TYPE[:ordered]
      orders=Order.where(status:Order::TYPE[:ordered]).order("created_at DESC")

    elsif params[:orders_type]===Order::TYPE[:paid]
      orders=Order.where(status:Order::TYPE[:paid]).order("created_at DESC")

    elsif params[:orders_type]===Order::TYPE[:completed]
      orders=Order.where(status:Order::TYPE[:completed]).order("created_at DESC")

    else
      orders=Order.where(status:Order::TYPE[:cancelled]).order("created_at DESC")
    end
  end
end
