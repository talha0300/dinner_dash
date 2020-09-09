class OrdersController < ApplicationController
  before_action :set_cart ,only:[:create]


  def show
    @order=Order.find(params[:id])
    @cart=@order.cart
    @order_items=CartItem.joins("INNER JOIN items ON cart_items.item_id=items.id").where(cart_id:@cart.id).pluck(:item_id,:title,:quantity,:price)
  end

  def create
    @order=Order.place_order(@cart)
    if @order
      cart=Cart.get_new_cart(current_user.id)
      session[:shopping_cart]=cart
      redirect_to @order, :flash => { :success => "Successfully placed an order" }
    else
      redirect_to @cart, :flash => { :success => "Unknown Error Occured" }
    end
  end

  private
    def set_cart
      @cart=Cart.find_by(id:session[:shopping_cart]['id'])
    end
end
