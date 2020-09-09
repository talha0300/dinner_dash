class CartsController < ApplicationController
  before_action :set_cart, only: [:show,:create,:destroy]



  def show
    @cart_items= CartItem.joins("INNER JOIN items ON cart_items.item_id=items.id").where(cart_id:@cart.id).pluck(:item_id,:title,:quantity,:price)
    
  end


  #create function here do not create new cart but just it just add item to cart
  def create
    @item=Item.find_by(id:params[:item_id])
    if @item
      @cart.add_item(@item)
      redirect_to items_path
    end
  end




  #destroy function here do not destroy cart but just it just remove item from cart
  def destroy
    @item=Item.find_by(id:params[:item_id])
    @cart.remove_item(@item)
    redirect_to @cart
  end



  private
    def set_cart
      @cart=Cart.find_by(id:session[:shopping_cart]['id'])
    end
end
