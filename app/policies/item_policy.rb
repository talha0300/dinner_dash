class ItemPolicy < ApplicationPolicy
  attr_reader :user, :item

  def initialize(user, item)
    @user = user
    @item = item
  end

  def create?
    user ? user.admin? : false
  end

  def update?
    user ? user.admin? : false
    
  end


  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
