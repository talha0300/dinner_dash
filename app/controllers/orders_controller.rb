class OrdersController < ApplicationController
  before_action :set_cart ,only:[:create]
  before_action :set_order,only:[:single_order,:mark_complete_order,:mark_paid_order,:cancel_order]


  def index
    @orders=Order.recent_orders(current_user)
  end

  def show
    @order=Order.find(params[:id])
    @cart=@order.cart
    @order_items=CartItem.get_cart_items(@cart)
  end



  def create
    @order=Order.place_order(@cart)
    if @order
      cart=Cart.get_new_cart(current_user.id)
      session[:shopping_cart]=cart
      OrderMailer.with(order: @order).new_order_email.deliver_now
      redirect_to @order, flash:{ success:"Successfully placed an order" }
    else
      redirect_to @cart, flash:{ success:"Operation Failed" }
    end
  end


  # For Admin
  def all_orders
    authorize Item,:create?, policy_class:ItemPolicy
    @grouped_orders=Order.group(:status).count
    @orders=Order.get_orders(params)
  end



  # For Admin
  def single_order
    authorize Item,:create?, policy_class:ItemPolicy
  end

  #for admin
  def mark_paid_order
    authorize Item,:create?, policy_class:ItemPolicy
    if @order.mark_paid
      redirect_to single_order_order_path(@order.id),flash:{ success:"Successfully marked order as paid" }
    else
      redirect_to single_order_order_path(@order.id),flash:{ success:"Operation Failed" }
    end
  end

  # for Admin
  def mark_complete_order
    authorize Item,:create?, policy_class:ItemPolicy
    if @order.mark_completed
      redirect_to single_order_order_path(@order.id),flash:{ success:"Successfully marked order as completed" }
    else
      redirect_to single_order_order_path(@order.id),flash:{ success:"Operation Failed" }
    end
  end

  # for admin and users
  def cancel_order
    if @order.cancel
      redirect_to single_order_order_path(@order.id),flash:{ success:"Successfully cancelled the order" }
    else
      redirect_to single_order_order_path(@order.id),flash:{ success:"Operation Failed" }
    end
  end
  private
    def set_cart
      @cart=Cart.find_by(id:session[:shopping_cart]['id'])
    end
    def set_order
      @order=Order.find(params[:id])
    end
end
