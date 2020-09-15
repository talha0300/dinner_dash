class User < ApplicationRecord
  has_one :cart
  has_many :favourite_items
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

  def self.save_guest
    user= User.new(user_name:"guest#{(0...rand(25)).map { (65 + rand(26)).chr }.join}",email:"guest#{(0...rand(25)).map { (65 + rand(26)).chr }.join}@unknown.com")
    user.save(validate: false)
    user
  end


end
