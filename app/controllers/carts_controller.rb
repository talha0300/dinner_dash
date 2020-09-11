class CartsController < ApplicationController
  before_action :set_cart, only: [:show,:create,:destroy]



  def show

    @cart_items= CartItem.get_cart_items(@cart)
    
  end


  #create function here do not create new cart but just add item to cart
  def create
    @item=Item.find_by(id:params[:item_id])

    if @item && @cart

      @cart.add_item(@item)
      redirect_to items_path
    else
      redirect_to record_not_found_home_path(1)
    end
  end



  def destroy
    @item=Item.find_by(id:params[:item_id])
    if @item && @cart
      @cart.remove_item(@item)
      redirect_to cart_path(@cart)
    else
      redirect_to record_not_found_home_path(1)
    end
  end



  private
    def set_cart
      @cart=Cart.find_by(id:session[:shopping_cart]['id'])
    end
end
