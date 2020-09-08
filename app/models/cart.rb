class Cart < ApplicationRecord


  belongs_to :user, optional: true
  has_many :cart_items
  has_many :items,through: :cart_items


  def add_item(item)
    cart_item=self.cart_items.find_by(item_id:item.id)
    if cart_item
      cart_item.update(quantity:cart_item[:quantity]+1)
    else
      cart_item.create(item_id:item.id)
    end
  end

end
