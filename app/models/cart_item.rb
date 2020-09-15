class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item


  def self.get_cart_items(cart)

    self.select("items.id, items.title,cart_items.quantity,items.price").joins("INNER JOIN items ON cart_items.item_id=items.id").where(cart_id:cart.id)
  end

  def self.total_cart_price(cart)
    total = self.get_cart_items(cart).sum("price*quantity")
  end

  def self.add_item_to_cart(params)
    cart_item=params[:cart].cart_items.find_or_initialize_by(item_id:params[:item][:id],cart_id:params[:cart][:id])
    if cart_item.new_record?
      cart_item.save
    else
      cart_item.update!(quantity:cart_item[:quantity]+1)
    end
  end

  def self.remove_item_from_cart(params)
    cart_item=params[:cart].cart_items.find_by(item_id:params[:item][:id])

    if cart_item[:quantity]===1
      cart_item.destroy
    else
      cart_item.update(quantity:cart_item[:quantity]-1)
    end
  end


  def item_price
    self.price * self.quantity
  end

end
