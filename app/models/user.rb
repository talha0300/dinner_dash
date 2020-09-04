class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  enum role: [:standard,:admin]
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable

  after_initialize do
    if self.new_record?
      self.role ||= :standard
    end
  end



end
