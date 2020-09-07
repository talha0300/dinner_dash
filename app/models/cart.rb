class Cart < ApplicationRecord
  belongs_to :item

  belongs_to :user, optional: true

  has_many :items
end
