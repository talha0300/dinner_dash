class ItemPolicy < ApplicationPolicy
  attr_reader :user, :item

  def initialize(user, item)
    @user = user
    @item = item
  end

  def create?
    if user
      user.admin?
    else
      false
    end
  end

  def update?
    if user
      user.admin?
    else
      false
    end
  end


  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
