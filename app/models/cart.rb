class Cart < ApplicationRecord


  belongs_to :user, optional: true
  has_many :cart_items
  has_many :items,through: :cart_items
  has_one :order


  def add_item(item)
    CartItem.add_item_to_cart(cart:self,item:item)
  end

  def remove_item(item)
    CartItem.remove_item_from_cart(cart:self,item:item)
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
