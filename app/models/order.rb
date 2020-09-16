class Order < ApplicationRecord
  belongs_to :cart
  belongs_to :user
  enum status: [:ordered,:completed,:cancelled,:paid]
  TYPE={ordered:"ordered",completed:"completed",cancelled:"cancelled",paid:"paid",all:"all"}

  after_initialize do
    if self.new_record?
      self.status ||= :ordered
    end
  end

  def self.recent_orders(current_user)
    self.where(user_id:current_user.id).order("created_at DESC")
  end




  def self.place_order(cart)
    total=self.total_order_price(cart)
    order=self.new(cart_id:cart.id,user_id:cart.user_id,total_amount:total)
    if order.save!
      order
    else
      false
    end
  end

  def self.total_order_price(cart)
    CartItem.total_cart_price(cart)
  end

  def self.get_orders(params)
    case params[:orders_type]
    when self::TYPE[:all]
      orders=self.all.sort
    when self::TYPE[:ordered]
      orders=self.where(status:self::TYPE[:ordered]).sort
    when self::TYPE[:paid]
        orders=self.where(status:self::TYPE[:paid]).sort
    when self::TYPE[:completed]
        orders=self.where(status:self::TYPE[:completed]).sort
    when self::TYPE[:cancelled]
        orders=self.where(status:self::TYPE[:cancelled]).sort
    end

  end


  def cancel
    self.update(status:"cancelled")
  end

  def mark_completed
    self.update(status:"completed")
  end

  def mark_paid
    self.update(status:"paid")
  end

  def sort
    self.order("created_at DESC")
  end


end
