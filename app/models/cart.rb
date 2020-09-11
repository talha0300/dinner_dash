class Cart < ApplicationRecord


  belongs_to :user, optional: true
  has_many :cart_items
  has_many :items,through: :cart_items


  def add_item(item)

    cart_item=self.cart_items.find_or_initialize_by(item_id:item.id,cart_id:self.id)
    if cart_item.new_record?
      cart_item.save
    else
      cart_item.update!(quantity:cart_item[:quantity]+1)
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

end
