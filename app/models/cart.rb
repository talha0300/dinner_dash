class Cart < ApplicationRecord


  belongs_to :user, optional: true
  has_many :cart_items
  has_many :items,through: :cart_items
  has_one :order


  def add_item(item)
    cart_item=self.cart_items.find_by(item_id:item.id)

    if cart_item
      cart_item.update(quantity:cart_item[:quantity]+1)
    else
      CartItem.create(item_id:item.id,cart_id:self.id,quantity:1)
    end
  end

  def remove_item(item)
    cart_item=self.cart_items.find_by(item_id:item.id)

    if cart_item[:quantity]===1
      cart_item.destroy
    else
      cart_item.update(quantity:cart_item[:quantity]-1)
    end
  end

  def self.get_new_cart(user_id)
    shopping_cart=Cart.new(user_id:user_id)
    if shopping_cart.save(validate: false)
      shopping_cart
    else
      false
    end
  end

end
