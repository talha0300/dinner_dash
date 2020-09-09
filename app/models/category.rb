class Category < ApplicationRecord
  has_many:items, through: :categorizations



  def alreadyexist?
    category=Category.where('lower(name) = ?', self[:name].downcase).first

    if category
      true
    else
      false
    end
  end
end
