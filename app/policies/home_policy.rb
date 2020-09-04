class HomePolicy < Struct.new(:user, :home)

  def show?
    if user
      user.role == 'admin'
    else
      false
    end
  end
end
