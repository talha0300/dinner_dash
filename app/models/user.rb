class User < ApplicationRecord
  has_one :cart
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  enum role: [:standard,:admin]
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable

  after_initialize do
    if self.new_record?
      self.role ||= :standard
    end
  end

  
  def guest_user
    User.find_by(id:session[:guest_user_id]) if session[:guest_user_id]
  end

  def guest?
    !!guest_user
  end

end
