module CartItemsHelper
  def all_cart_items(order)
    CartItem.get_cart_items(cart=Cart.find(order.cart_id))
  end
end
