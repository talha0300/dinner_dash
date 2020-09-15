class HomePolicy < Struct.new(:user, :home)

  def show?
    user ? user.role == 'admin' : false
  end
end
