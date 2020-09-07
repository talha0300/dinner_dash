class Category < ApplicationRecord
  has_many:items, through: :categorizations
end
