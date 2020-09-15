class Category < ApplicationRecord
  has_many :categorizations,dependent: :destroy
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
    if Category.exists?(['lower(name) LIKE ?', self[:name].downcase])
      true
    else
      false
    end
  end



end
