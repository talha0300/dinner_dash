class ItemPolicy < ApplicationPolicy
  attr_reader :user, :item

  def initialize(user, item)
    @user = user
    @item = item
  end

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end


  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
