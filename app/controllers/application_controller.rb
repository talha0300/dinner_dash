class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :currert_shopping_cart


  def currert_shopping_cart

    if session[:shopping_cart]
      @shopping_cart= session[:shopping_cart]
    else
      @shopping_cart=Cart.create
      session[:shopping_cart]=@shopping_cart
    end

    debugger
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:user_name,:display_name, :email, :password)}
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password)}
    end
end
