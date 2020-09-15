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
      not_found

    end
  end


#destroy function here do not destroy cart but just remove item from cart

  def destroy
    @item=Item.find_by(id:params[:item_id])
    if @item && @cart
      @cart.remove_item(@item)
      redirect_to cart_path(@cart)
    else
      not_found
    end
  end



  private
    def set_cart
      @cart=Cart.find_by(id:session[:shopping_cart]['id'])
    end
end
