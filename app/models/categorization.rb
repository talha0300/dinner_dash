class Categorization < ApplicationRecord
  belongs_to :item
  belongs_to :category
  validates :category_id, uniqueness: { scope: [:item_id] }

  def self.get_assigned_categories
    self.select("categorizations.id,categories.name,items.title").joins(:category,:item).order("title DESC")
  end

  def self.assign_category(item,category)
    categorization=Categorization.new(item_id:item.id,category_id:category.id)
    if categorization.save
      true
    else
      false
    end
  end
end
