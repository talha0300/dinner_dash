class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  #before_action :reset_session
  before_action :create_guest
  before_action :currert_shopping_cart





  def currert_shopping_cart
    
    if user_signed_in?
      if session[:shopping_cart]
        @shopping_cart= session[:shopping_cart]
        session[:shopping_cart]=@shopping_cart
      else
        @shopping_cart=Cart.create(user_id:current_user.id)
      end
    else

      if session[:shopping_cart]
        @shopping_cart= session[:shopping_cart]
      else
        @shopping_cart=Cart.new(user_id:session[:guest_user_id])
        @shopping_cart.save(validate: false)
        session[:shopping_cart]=@shopping_cart
      end
    end

  end

  def create_guest

    if !(user_signed_in? || session[:guest])

      session[:guest_user_id]=save_guest.id

    end
  end

  def save_guest
    guest_user_name="guest"+(0...rand(25)).map { (65 + rand(26)).chr }.join
    guest_email="guest"+(0...rand(25)).map { (65 + rand(26)).chr }.join + "@unknown.com"
    user= User.create(user_name:guest_user_name,email:guest_email)
    user.save(validate: false)
    session[:guest]=true
    user
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:user_name,:display_name, :email, :password)}
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password)}
    end
end
