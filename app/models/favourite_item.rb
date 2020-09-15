class FavouriteItem < ApplicationRecord
  belongs_to :user
  belongs_to :item

  def self.add_item(params)
    item=self.find_or_create_by(user_id:params[:user][:id],item_id:params[:item_id])
  end

  def self.remove_item(params)
    item=self.where(user_id:params[:user][:id],item_id:params[:item_id]).destroy_all
  end

end
