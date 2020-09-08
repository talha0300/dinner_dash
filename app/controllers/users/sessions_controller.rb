# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  after_action :assign_guest_cart_to_user,only: [:create]
  after_action :after_logout_setup, only: [:destroy]

  # before_action :configure_sign_in_params, only: [:create] :

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create

    super
  end

  # DELETE /resource/sign_out
  def destroy
    super

  end

  def assign_guest_cart_to_user

    session[:guest]=false
    @shopping_cart=Cart.find_by(id:session[:shopping_cart]['id'])
    @shopping_cart.update!(user_id:current_user.id)
    User.find_by(id:session[:guest_user_id]).destroy
    session[:guest_user_id]=nil
    session[:shopping_cart]=@shopping_cart
    

  end

  def after_logout_setup
    reset_session
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
