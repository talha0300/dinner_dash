class Category < ApplicationRecord
  has_many:items, through: :categorizations


  def self.get_categories(filter)
    categories=Category.all.pluck(:name)
    categories.unshift('all')
    if filter
      categories.unshift(categories.delete(filter))
    end
    categories
  end

  def alreadyexist?
    category=Category.where('lower(name) = ?', self[:name].downcase).first

    if category
      true
    else
      false
    end
  end



end
